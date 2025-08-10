{ pkgs, ...}: {
  imports = [
    ./qtile/default.nix
  ];

  services.xserver = {
    enable = true;
    autorun = false;
    
    desktopManager.runXdgAutostartIfNone = true;
    xkb.layout = "us";

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
	  setupCommands = ''
        ${pkgs.autorandr}/bin/autorandr --default default --change &
	  '';
    };

    videoDrivers = [ "nvidia" ];
  };
}
