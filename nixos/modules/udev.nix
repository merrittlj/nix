{ pkgs, ... }:
{
    services.udev = {
        packages = [ pkgs.qmk-udev-rules ];
        extraRules = ''
            SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"
        '';
    };
}

