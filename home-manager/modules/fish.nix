{
  programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = [
      gr = "grep -r -n -H -C 3";
      v = "neovim";
    ];

    generateCompletions = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    functions = {
      "fish_prompt" = ''
        set PROMPT "$PWD $(hostname)"

        set -l nix_shell_info (
	  if test -n "$IN_NIX_SHELL"
            set PROMPT "<nix-shell> $PROMPT"
	  end
	)

	if fish_is_root_user
	  set PROMPT "$PROMPT""#"
	else
          set PROMPT "$PROMPT"">"
	end

        builtin echo -ns $PROMPT
      '';
    };

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  }
}
