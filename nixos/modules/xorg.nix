{ pkgs, config, host, ...}: {
  services.xserver = {
    enable = true;
    autorun = false;

    dpi = { laptop = 192; desktop = 80; }.${host} or 80;
    videoDrivers = { laptop = [ "nvidia" ]; desktop = [ "modesetting" ]; }.${host} or [ "modesetting" ];
    
    windowManager.qtile = {
      enable = true;
      package = pkgs.qtile;
      extraPackages = python313Packages: with python313Packages; [
        iwlib
      ];
    };

    desktopManager.runXdgAutostartIfNone = true;
    xkb.layout = "us";
    xkb.variant = { laptop = "dvp"; desktop = ""; }.${host};
    xkb.options = { laptop = "ctrl:swapcaps"; desktop = ""; }.${host};

    displayManager = {
        lightdm.enable = true;
        setupCommands = ''
            ${pkgs.autorandr}/bin/autorandr --default ${host} --change &
        '';
    };
  };

  services.urxvtd.enable = true;
}
