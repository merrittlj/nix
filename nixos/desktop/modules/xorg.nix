{ pkgs, ...}: {
  services.xserver = {
    dpi = 80;
    videoDrivers = [ "nvidia" ];
  };
}
