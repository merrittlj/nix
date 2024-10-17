{
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"
    '';
  };
}
