{ username, ... }:
{
	programs.bash = {
		enable = true;

		sessionVariables = {
          FLAKE_PATH = "/home/${username}/nix";
		};
	};
}
