{ pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    
    windowManager.ratpoison.enable = true; 
    xkb.layout = "us";

    displayManager.lightdm = {
      enable = true;
    };
    # startx.enable = true;

    videoDrivers = [ "nvidia" ];
  };
}
