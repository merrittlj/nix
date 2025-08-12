{ pkgs, config, ...}: {
  services.xserver = {
    enable = true;
    autorun = false;
    
    windowManager.qtile = {
      enable = true;
      package = pkgs.qtile;
    };

    desktopManager.runXdgAutostartIfNone = true;
    xkb.layout = "us";

    displayManager = {
      lightdm.enable = true;
	  setupCommands = ''
        ${pkgs.autorandr}/bin/autorandr --default default --change &
	  '';
    };
  };

  services.urxvtd.enable = true;
}
