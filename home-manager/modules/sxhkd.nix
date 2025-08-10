{ pkgs, ... }:
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + d" = "urxvt";
      "super + g" = "firefox";
      "super + q" = "berryc quit";
      "XF86MonBrightness{Up,Down}" = "brightness-control /sys/class/backlight/gmux_backlight/brightness {up,down} 25";
    };
  };
}
