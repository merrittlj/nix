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


  # Recursive grep w/ formatting
  gr = final.writeShellApplication {
    name = "gr";
    runtimeInputs = with final; [ gnugrep ];

    text = ''
  	  grep -r -n -H -C 3 "$1" "$2"
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
  }
