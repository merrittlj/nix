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
    rvh
    rv
    gr
    bt
    battery
    batterylife
    batterye
    brightness-control

    rpbar


    # Misc.
    home-manager
    pavucontrol
  ];
  
  fonts.packages = with pkgs; [
    libertinus
  ];
}
