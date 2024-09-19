{ config, pkgs, ... }: {
	imports = [
        ./packages.nix
		./modules/bundle.nix
	];	

        nixpkgs.overlays = [
          (import ./overlays/scripts.nix)
        ];

	home = {
		username = "lucas";
		homeDirectory = "/home/lucas";
		stateVersion = "24.05";
                
		file = {
                  ".ratpoisonrc".source = ./config/_ratpoisonrc;
                  ".vim".source = ./config/_vim;
		};
	};
}
