{ config, pkgs, username, nixvim, ... }: {
	imports = [
        ./packages.nix
		./modules/bundle.nix
        nixvim.homeManagerModules.nixvim
	];	

    news.display = "silent";
	home = {
		username = "${username}";
		homeDirectory = "/home/${username}";
		stateVersion = "24.05";
                
		file = {
                  ".ratpoisonrc".source = ./config/_ratpoisonrc;
                  ".vim".source = ./config/_vim;
		};
	};
}
