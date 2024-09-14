{
	programs.bash = {
		enable = true;
		shellAliases = 
		let
			flake_path = "~/nix";
		in {
			rb = "doas nixos-rebuild switch --flake ${flake_path}";
			hm = "home-manager switch --flake ${flake_path}";
			v = "vim";
		};
	};
}
