{ pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    
    windowManager.ratpoison.enable = true; 
    xkb.layout = "us";
    xkb.variant = "dvp";

    displayManager.lightdm = {
      enable = true;
    };
    # startx.enable = true;

    videoDrivers = [ "nvidia" ];
  };
}
