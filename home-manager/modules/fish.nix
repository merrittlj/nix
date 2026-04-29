{ pkgs, host, ... }:
{
  programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = {
      d = "doas";
      v = "nvim";
      p = "python";
      rb = "doas nixos-rebuild switch --flake path:$FLAKE_PATH#${host}";
      ihatejava = "_JAVA_AWT_WM_NONREPARENTING=1";
    };

    generateCompletions = true;

    interactiveShellInit = ''
      set fish_greeting
      set -gx EDITOR nvim
      set FLAKE_PATH "/home/$(whoami)/nix"
      set WALLPAPERS_PATH "/home/$(whoami)/wallpapers"

      if not gpg --list-secret-keys EA01AEDB989800FC &>/dev/null
        gpg --batch --pinentry-mode loopback --import /run/secrets/gpg_key/andesite_git 2>/dev/null
      end
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

      # Invocation: pythonenv 3 package1 package2 .. packageN
      # or:         pythonenv 2 ..
      "pythonenv" = ''
        if set -q argv[2]
            set argv $argv[2..-1]
        end
 
        for el in $argv
            set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
 
        nix-shell -p $ppkgs
      '';

      "xc" = ''
        eval $argv[1..-1] &| xclip -sel clip
      '';
    };

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };
}
