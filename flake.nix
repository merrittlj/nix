{
	description = "System configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";

		in {
			nixosConfigurations.fibonacci = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ ./nixos/configuration.nix ];
			};

			homeConfigurations.lucas = home-manager.lib.homeManagerConfiguration {
				# pkgs = nixpkgs.legacyPackages.${system};
                pkgs = import nixpkgs { 
                  inherit system;
                  config.allowUnfree = true;
                                  #overlays =
                                  #  let
                                #	  scriptsOverlay = (import ./home-manager/overlays/scripts.nix);
                                #	in [
                                #	  scriptsOverlay
                                #	];
                };
				modules = [ ./home-manager/home.nix ];
			};
		};
}
