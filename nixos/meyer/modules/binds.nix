{ pkgs, ... }:
{
  services.actkbd = {
    enable = true;
	bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.brightness-control}/bin/brightness-control /sys/class/backlight/gmux_backlight/brightness up 25"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.brightness-control}/bin/brightness-control /sys/class/backlight/gmux_backlight/brightness down 25"; }
      { keys = [ 115 ]; events = [ "key" ]; command = "${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/volume.sock <<< \"s 5%+\" && ${pkgs.set_status}/bin/set_status"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/volume.sock <<< \"s 5%-\" && ${pkgs.set_status}/bin/set_status"; }
      { keys = [ 113 ]; events = [ "key" ]; command = "${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/volume.sock <<< \"s toggle\" && ${pkgs.set_status}/bin/set_status"; }
	];
  };
}
