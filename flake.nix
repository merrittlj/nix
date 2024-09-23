{
	description = "System configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

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
			hostname = "fibonacci";
            overlays = [
			    (import ./nixos/overlays/scripts.nix)
                (import ./nixos/overlays/rpbar.nix)
			];
            pkgs = import nixpkgs { inherit overlays; };

		in {
			nixosConfigurations = {
			  fibonacci = nixpkgs.lib.nixosSystem {
			    inherit system; inherit pkgs;

				specialArgs = {
                  inherit username; inherit hostname;
				};

				modules = [ 
				  ./nixos/configuration.nix
				];
			  };
			};

			homeConfigurations = {
              lucas = home-manager.lib.homeManagerConfiguration {
                inherit system; inherit pkgs;

				extraSpecialArgs = {
                  inherit username; inherit hostname; inherit nixvim;
				};

				modules = [
                  ./home-manager/home.nix
                ];
			  };
            };
	   };
}
