{ pkgs, ... }:
{
  services.actkbd = {
    enable = true;
	bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.brightness-control}/bin/brightness-control /sys/class/backlight/gmux_backlight/brightness up 25"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.brightness-control}/bin/brightness-control /sys/class/backlight/gmux_backlight/brightness down 25"; }
      # found through: doas actkbd -n -s -d /dev/input/event7
	  # up volume: 115
	  # down volume: 114
	  # mute: 113
	];
  };
}
