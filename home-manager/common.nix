{ config, pkgs, username, nixvim, ... }: {
	imports = [
        ./packages.nix
		./modules/bundle.nix
        nixvim.homeModules.nixvim
	];	

    news.display = "silent";
	home = {
		username = "${username}";
		homeDirectory = "/home/${username}";
		stateVersion = "24.05";
	};
    xdg.configFile = {
      #"qtile" = {
      #  source = ./src/qtile;
      #  recursive = true;
      #};
      "fcitx5".source = ./src/fcitx5;
    };
}
