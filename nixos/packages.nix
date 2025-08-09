{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

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
    berry

    # Overlays
    rb
    hm
    pb
    wh
    gp
    gr
    battery
    batterylife
    brightness-control

    # Misc.
    home-manager
    pavucontrol
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
}
