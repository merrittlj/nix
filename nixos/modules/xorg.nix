{ pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    
    windowManager.ratpoison.enable = true; 
    desktopManager.runXdgAutostartIfNone = true;
    xkb.layout = "us";

    displayManager = {
      lightdm.enable = true;
	  setupCommands = ''
        ${pkgs.autorandr}/bin/autorandr --default default --change &
	  '';
    };

    videoDrivers = [ "nvidia" ];
  };
}
