{ username, ... }:
{
	programs.bash = {
		enable = true;

		sessionVariables = {
          FLAKE_PATH = "/home/${username}/nix";
            WALLPAPERS_PATH = "/home/${username}/wallpapers";
		};

		shellAliases = {
          d = "doas";
          dr = "doas rb";
		  v = "vim";
          n = "ninja";
          c = "cmake $RV_PATH -G Ninja";
          ihatejava = "_JAVA_AWT_WM_NONREPARENTING=1";
		};
	};
}
