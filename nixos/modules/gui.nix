{ pkgs, config, host, ...}: {
  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;

      settings = {
        "org/gnome/desktop/interface" = {
          scaling-factor = { laptop = 2; desktop = 1; }.${host} or 1;
          text-scaling-factor = 1.0;
        };
      };
    };

    desktopManager.gnome.enable = true;

    xkb = {
      layout = "us";
      variant = { laptop = "dvp"; desktop = ""; }.${host};
      options = { laptop = "ctrl:swapcaps"; desktop = ""; }.${host};
    };

    dpi = { laptop = 192; desktop = 80; }.${host} or 80;
  };
}
