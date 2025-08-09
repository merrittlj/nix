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
                  ".config/fcitx5/".source = ./config/fcitx5;
                  ".config/berry/".source = ./config/berry;
		};
	};
}
