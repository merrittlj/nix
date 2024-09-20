{ username, ... }:
{
	programs.bash = {
		enable = true;

		sessionVariables = {
          FLAKE_PATH = "/home/${username}/nix";
          RV_PATH = "/home/${username}/programming/embedded/raven";
          RVH_PATH = "/home/${username}/programming/embedded/raven-hardware";
          DH_PATH = "/home/${username}/programming/embedded/dash";
		  WALLPAPERS_PATH = "/home/${username}/wallpapers";
		};
	};
}
