{ pkgs, ...}: {
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "dvp";
    xkb.options = "ctrl:swapcaps";
  };
}
