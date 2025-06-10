{ pkgs, ...}:
{
  services.udev = {
    packages = [
      pkgs.android-udev-rules
    ];
    extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"
    '';
  };
}
