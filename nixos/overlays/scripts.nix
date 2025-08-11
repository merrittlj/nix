final: prev:

{
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
}
