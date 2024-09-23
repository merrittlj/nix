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

		in {
			nixosConfigurations = {
			  fibonacci = nixpkgs.lib.nixosSystem {
			    inherit system;

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
                pkgs = import nixpkgs { 
                  inherit system;
                  config.allowUnfree = true;

                  overlays = 
				    let
				      scriptsOverlay = (import ./home-manager/overlays/scripts.nix);
                      rpbarOverlay = (import ./home-manager/overlays/rpbar.nix);
  			        in [
				      scriptsOverlay
					  rpbarOverlay
				    ];
                   
                };

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
