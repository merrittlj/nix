{ pkgs, ...}: {
  services.xserver = {
    dpi = 192;

    xkb.layout = "us";
    xkb.variant = "dvp";
    xkb.options = "ctrl:swapcaps";

    videoDrivers = [ "modesetting" ];
  };
}
