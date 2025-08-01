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
                  inputs.nixpkgs.follows = "nixpkgs-unstable";
                };

        alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
	};

	outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, alacritty-theme, ... }@inputs:
		let
			system = "x86_64-linux";
            username = "lucas";
            overlays = [
              (alacritty-theme.overlays.default)

			  (import ./nixos/overlays/scripts.nix)
              (import ./nixos/overlays/rpbar.nix)
              (import ./nixos/overlays/stm32cubeprog.nix)
              #(import ./nixos/overlays/cura.nix)

              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = final.system;
                  config = {
                    allowUnfree = true;
                    android_sdk.accept_license = true;
                  };
                };
              })
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
                  { nixpkgs.overlays = [
				    (import ./nixos/mendeleev/overlays/scripts.nix)
				  ];}
				  ./nixos/common.nix
				  ./nixos/mendeleev/default.nix
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
                  { nixpkgs.overlays = [
				    (import ./nixos/meyer/overlays/scripts.nix)
				  ];}
				  ./nixos/common.nix
				  ./nixos/meyer/default.nix
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
