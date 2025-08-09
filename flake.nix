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

	};

	outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }@inputs:
		let
		system = "x86_64-linux";
	username = "lucas";
	overlays = [
			(import ./nixos/overlays/scripts.nix)

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
			desktop = nixpkgs.lib.nixosSystem {
				inherit system;

				specialArgs = {
					inherit username;
					hostname = "pluto";
				};

				modules = [ 
				{ nixpkgs.overlays = overlays; }
				{ nixpkgs.overlays = [
			#		(import ./nixos/desktop/overlays/scripts.nix)
				];}
				./nixos/common.nix
					./nixos/desktop/default.nix
				];
			};
			laptop = nixpkgs.lib.nixosSystem {
				inherit system;

				specialArgs = {
					inherit username;
					hostname = "saturn";
				};

				modules = [ 
				{ nixpkgs.overlays = overlays; }
				{ nixpkgs.overlays = [
			#		(import ./nixos/laptop/overlays/scripts.nix)
				];}
				./nixos/common.nix
					./nixos/laptop/default.nix
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
