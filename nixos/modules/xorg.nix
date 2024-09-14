{
  services.xserver = {
    enable = true;
    autorun = false;
    
    windowManager.ratpoison.enable = true; 
    displayManager.startx.enable = true;
    xkb.layout = "us";

    videoDrivers = [ "nvidia" ];
  };
}
