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
                  ".rpbar.ini".source = ./config/_rpbar.ini;
                  ".config/fcitx5/".source = ./config/fcitx5;
		};
	};
}
