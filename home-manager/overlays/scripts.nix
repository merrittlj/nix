final: prev:

{
  # NixOS rebuild
  rb = final.writeShellApplication {
    name = "rb";
    runtimeInputs = with final; [ nixos-rebuild ];

    text = ''
      nixos-rebuild switch --flake "$FLAKE_PATH"
    '';
  };

  # Home manager rebuild
  hm = final.writeShellApplication {
    name = "hm";
    runtimeInputs = with final; [ home-manager ];

    text = ''
      home-manager switch --flake "$FLAKE_PATH"
    '';
  };

  # Raven hardware project launch
  rvh = final.writeShellApplication {
    name = "rvh";
    runtimeInputs = with final; [ kicad okular firefox kitty ];

    text = ''
      kicad "$RVH_PATH"/kicad/kicad.kicad_pro &
  	  okular "$RVH_PATH"/reference/display.pdf &
  	  firefox &
  	  cd "$RVH_PATH"
  	  kitty
    '';
  };

  # Raven code launch
  rv = final.writeShellApplication {
    name = "rv";
    runtimeInputs = with final; [ kitty ];

    text = ''
      cd "$RV_PATH"
  	  kitty
  	  vim
    '';
  };

  # Recursive grep w/ formatting
  gr = final.writeShellApplication {
    name = "gr";
    runtimeInputs = with final; [ gnugrep ];

    text = ''
  	  grep -r -n -H -C 3 "$1" "$2"
    '';
  };

  # Background management
  bgt = final.writeShellApplication {
    name = "bgt";
    runtimeInputs = with final; [ nitrogen gnugrep gnused ];

    text = ''
  	  if [ "$2" = "s" ]; then
        nitrogen --random "$WALLPAPERS_PATH" --set-zoom-fill --save
      elif [ "$2" = "r" ]; then
        rm "$(bg c)"
  	    bg s
  	  else
        grep "file" ~/.config/nitrogen/bg-saved.cfg | sed "s/file=//"
  	  fi
    '';
  };

  #unzip-dir = final.writeShellApplication {
  #  name = "unzip zip files in the current dir";
  #  runtimeInputs = with final; [ gnugrep gawk unzip ];
#
#    text = ''
#      ls *.zip | grep awk -F'.zip' '{print "unzip "$0" -d "$1}' | sh
#    '';
#  };
}
