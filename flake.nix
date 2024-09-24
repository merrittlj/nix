{
	description = "System configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

                nixvim = {
                  url = "github:nix-community/nixvim";
                  inputs.nixpkgs.follows = "nixpkgs";
                };
	};

	outputs = { nixpkgs, home-manager, nixvim, ... }:
		let
			system = "x86_64-linux";
            username = "lucas";
            overlays = [
			  (import ./nixos/overlays/scripts.nix)
              (import ./nixos/overlays/rpbar.nix)
			];
		in {
			nixosConfigurations = {
			  mendeleev = nixpkgs.lib.nixosSystem {
			    inherit system;

				specialArgs = {
                  inherit username;
                  hostname = "mendeleev";
				};

				modules = [ 
				  { nixpkgs.overlays = overlays; }
				  ./nixos/common.nix
				  ./nixos/mendeleev/conf.nix
				];
			  };
              meyer = nixpkgs.lib.nixosSystem {
			    inherit system;

				specialArgs = {
                  inherit username;
				  hostname = "meyer";
				};

				modules = [ 
				  { nixpkgs.overlays = overlays; }
				  ./nixos/common.nix
				  ./nixos/meyer/conf.nix
				];
			  };
			};

			homeConfigurations = {
              lucas = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { inherit system overlays; };

				extraSpecialArgs = {
                  inherit username nixvim;
				};

				modules = [
                  ./home-manager/home.nix
                ];
			  };
            };
	   };
}
