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
    neofetch
    file
    tree
    htop
    unzip
    zip
    yt-dlp
    read-edid
    efibootmgr
    bc
    actkbd
    qmk
    socat
    appimage-run


    libGL

    # GUI utils
    feh
    maim

    # Xorg
    ratpoison
    xclip
    xorg.xdpyinfo
    autorandr
    lightdm

    # Overlays
    rb
    hm
    pb
    wh
    gp
    rvh
    rv
    gr
    bt
    battery
    batterylife
    batterye
    brightness-control
    volume-ctl
    volume-ctl-handler
    sdmount

    jdk21

    rpbar
    stm32cubeprog.installerEnv
    stm32cubeprog.progEnv

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
    # Enabling these seems to override the default font in Firefox
    #wqy_zenhei
	#vistafonts-chs
  ];
}
