{ pkgs, config, ...}: {
  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]);

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    cheese # webcam
    gnome-music
    gedit # gui text editor
    geary # email reader
    gnome-characters
    tali # poker
    iagno # go
    hitori # sudoku
    atomix # puzzle
    yelp # help view
    gnome-contacts

    libsecret

    wl-clipboard
    seahorse
  ];

  services.gnome.gnome-keyring.enable = true;
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
}
