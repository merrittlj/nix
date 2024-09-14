{ config, pkgs, ... }: {
	imports = [
		./bash.nix
                ./packages.nix
		./modules/bundle.nix
	];	

	home = {
		username = "lucas";
		homeDirectory = "/home/lucas";
		stateVersion = "24.05";
	};
}
