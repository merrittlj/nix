{ pkgs, ... }:
{
    services.udev = {
        packages = [ pkgs.android-udev-rules ];
        extraRules = ''
            SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"

            # display backlight
            #ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chmod o+w /sys/class/backlight/%k/brightness" OPTIONS="log_level=debug"
            # keyboard backlight
            #ACTION=="add", SUBSYSTEM=="leds",      RUN+="${pkgs.coreutils-full}/bin/chmod o+w /sys/class/leds/%k/brightness"
        '';
    };
}

