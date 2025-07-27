final: prev:

{
  # NixOS rebuild
  rb = final.writeShellApplication {
    name = "rb";
    runtimeInputs = with final; [ nixos-rebuild hostname ];

    text = ''
      nixos-rebuild switch --flake "$FLAKE_PATH"#"$(hostname)"
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
  
  # Build package from package dir
  pb = final.writeShellApplication {
    name = "pb";
	runtimeInputs = with final; [ nix ];
  
    text = ''
      nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
	'';
  };

  # Find package path
  wh = final.writeShellApplication {
    name = "wh";
	runtimeInputs = with final; [ coreutils which gnused ];
  
    text = ''
      realpath "$(which "$1")" | sed -E 's/.*-(.*)-.*\/bin\/.*/\1/g'
	'';
  };

  # Git upload process
  gp = final.writeShellApplication {
    name = "gp";
	runtimeInputs = with final; [ git ];
  
    text = ''
      while true; do
	    read -r -p "Add? " yn
	    case $yn in
	      [Yy]* | "" ) git add .; break;;
		  [Nn]* ) ;;
          * ) echo "Please answer yes or no.";;
		  esac
	  done
	  commit=0;
      while true; do
	    read -r -p "Commit? " yn
	    case $yn in
	      [Yy]* | "" ) commit=1; break;;
		  [Nn]* ) commit=0;;
          * ) echo "Please answer yes or no.";;
		  esac
	  done
	  if [[ "$commit" == 1 ]]; then
	    read -r -p "Message? " message
		git commit -m "$message"
	  fi
      while true; do
	    read -r -p "Push? " yn
	    case $yn in
	      [Yy]* | "" ) git push; break;;
		  [Nn]* ) ;;
          * ) echo "Please answer yes or no.";;
		  esac
	  done
	  echo "Done";
	'';
  };


  # Raven hardware project launch
  rvh = final.writeShellApplication {
    name = "rvh";
    runtimeInputs = with final; [ kicad okular firefox alacritty ];

    text = ''
      kicad "$RVH_PATH"/kicad/kicad.kicad_pro &
  	  okular "$RVH_PATH"/reference/display.pdf &
  	  firefox &
  	  cd "$RVH_PATH"
  	  alacritty
    '';
  };

  # Raven code launch
  rv = final.writeShellApplication {
    name = "rv";
    runtimeInputs = with final; [ alacritty ];

    text = ''
        alacritty --working-directory "$RV_PATH"/build -e sh -c "nix-shell ../shell.nix"
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
  bt = final.writeShellApplication {
    name = "bt";
    runtimeInputs = with final; [ nitrogen gnugrep gnused ];

    text = ''
      MODE="''${1:-default}"
      if [ "$MODE" = "default" ]; then
        grep "file" ~/.config/nitrogen/bg-saved.cfg | sed "s/file=//"
      elif [ "$MODE" = "s" ]; then
        nitrogen --random "$WALLPAPERS_PATH" --set-zoom-fill --save
      elif [ "$MODE" = "x" ]; then
        nitrogen "$2" --set-zoom-fill --save
      elif [ "$MODE" = "r" ]; then
        rm "$(bt)"
  	    bt s
  	  fi
    '';
  };

  battery = final.writeShellApplication {
    name = "battery";
	runtimeInputs = with final; [ bc findutils ];

	text = ''
	  echo "$(echo "$(cat /sys/class/power_supply/BAT0/charge_now) / $(cat /sys/class/power_supply/BAT0/charge_full)" | bc -l) * 100" | bc -l | xargs printf %.2f
	  echo
	'';
  };

  batterylife = final.writeShellApplication {
    name = "batterylife";
	runtimeInputs = with final; [ bc ];

	text = ''
	  echo "$(cat /sys/class/power_supply/BAT0/charge_full) / $(cat /sys/class/power_supply/BAT0/charge_full_design)" | bc -l
	'';
  };

  batterye = final.writeShellApplication {
    name = "batterye";
	runtimeInputs = with final; [ ratpoison ];

	text = ''
	  ratpoison -c "echo $(cat /sys/class/power_supply/BAT0/status) $(battery)%"
	'';
  };

  brightness-control = final.writeShellApplication {
    name = "brightness-control";
    runtimeInputs = [];

    text = ''
      brightnessControl="$1"
      action="$2"
      step="$3"

      currentValue=$(cat "$brightnessControl")
      newValue=0

      if [ "$action" == "up" ]; then
         newValue=$(("$currentValue" + "$step"))
      elif [ "$action" == "down" ]; then
         newValue=$(("$currentValue" - "$step"))
      fi

      if [ "$newValue" -lt 0 ]; then
         newValue=0
      fi

      echo "$newValue" > "$brightnessControl"
      currentValue=newValue
	'';
  };

  volume-ctl = final.writeShellApplication {
    name = "volume-ctl";
	runtimeInputs = with final; [ coreutils-full socat volume-ctl-handler ];

	text = ''
	  SOCKET="/tmp/volume.sock"
	  if [ -S "$SOCKET" ]; then
	    echo "Removing existing socket $SOCKET..."
		rm -v "$SOCKET"
	  fi
      
      echo "Listening on socket $SOCKET..."
	  socat UNIX-LISTEN:"$SOCKET",fork SYSTEM:"volume-ctl-handler" &
	'';
  };

  volume-ctl-handler = final.writeShellApplication {
    name = "volume-ctl-handler";
	runtimeInputs = with final; [ coreutils-full gnused alsa-utils gawk ];

	text = ''
      while IFS="" read -r line || [[ -n "$line" ]]; do
		mode=$(cut -c1 <<< "$line")
		case $mode in
		  s)
		    echo "Set mode"
	        # shellcheck disable=SC2001
            command=$(sed 's#s\s\(.*\)#\1#' <<< "$line")
	        echo "Extracted: $command"
			amixer set Master "$command"
			;;
		  g)
            amixer get Master \
              | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }'
			;;
		  *)
		    echo "Unknown mode: $mode"
			;;
        esac
	  done
	'';
  };

  # Process of mounting and umounting an sdcard interactively
  sdmount = final.writeShellApplication {
    name = "sdmount";
    runtimeInputs = with final; [ coreutils-full ];

    text = ''
      mount /dev/sdc1 /home/lucas/sdcard -o umask=000
      while true; do
	    read -r -p "Done? " yn
	    case $yn in
	      [Yy]* | "" ) break;;
		  [Nn]* ) ;;
          * ) echo "Please answer yes or no.";;
		  esac
	  done
      umount sdcard
      eject /dev/sdc1
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
