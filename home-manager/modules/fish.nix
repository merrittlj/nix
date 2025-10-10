{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = {
      d = "doas";
      v = "neovim";
      rb = "doas nixos-rebuild switch --flake $FLAKE_PATH#$(hostname)";
      i_hate_java = "_JAVA_AWT_WM_NONREPARENTING=1 ";
    };

    generateCompletions = true;

    interactiveShellInit = ''
      set fish_greeting
      set -gx EDITOR nvim
      set FLAKE_PATH "/home/$(whoami)/nix"
      set WALLPAPERS_PATH "/home/$(whoami)/wallpapers"
    '';

    functions = {
      "fish_prompt" = ''
        set PROMPT "[$(whoami)@$(hostname):$PWD]"

        set -l nix_shell_info (
	  if test -n "$IN_NIX_SHELL"
            set PROMPT "<nix-shell> $PROMPT"
	  end
	)

	if fish_is_root_user
	  set PROMPT "$PROMPT""# "
	else
          set PROMPT "$PROMPT""\$ "
	end

        builtin echo -ns $PROMPT
      '';

      # Invocation: pythonEnv 3 package1 package2 .. packageN
      # or:         pythonEnv 2 ..
      "pythonEnv" = ''
        if set -q argv[2]
            set argv $argv[2..-1]
        end
 
        for el in $argv
            set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
 
        nix-shell -p $ppkgs
      '';
    };

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };
}
