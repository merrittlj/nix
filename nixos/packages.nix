{ config, lib, pkgs, ... }: {
  nix.package = pkgs.nixVersions.latest;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.12.41"
  ];

  environment.systemPackages = with pkgs; [
    # Development
    vim
    git
    gh
    gcc
    gnumake

    # CLI utils
    wget
    doas
    fastfetch
    file
    tree
    htop
    unzip
    zip
    yt-dlp
    read-edid
    efibootmgr
    bc
    socat
    appimage-run
    usbutils

    # GUI utils
    feh
    maim

    # Xorg
    xclip
    xorg.xdpyinfo
    autorandr
    lightdm

    # Overlays
    wh
    gp
    battery
    batterylife
    qtile

    # Misc.
    home-manager
    pavucontrol
    brightnessctl
    pciutils
  ];
  
  fonts.packages = with pkgs; [
    libertinus
    ibm-plex
    proggyfonts
    intel-one-mono
    noto-fonts-cjk-sans
    wqy_microhei
    smiley-sans
	lxgw-wenkai
	lxgw-neoxihei
    fantasque-sans-mono
    # Enabling these seems to override the default font in Firefox
    #wqy_zenhei
	#vistafonts-chs
  ];

  programs.fish.enable = true;
}
