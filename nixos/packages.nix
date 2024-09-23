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

    # GUI utils
    feh
    maim

    # Xorg
    ratpoison
    xclip
    xorg.xdpyinfo
    autorandr
    lightdm

    # Misc.
    home-manager
    pavucontrol
  ];
  
  fonts.packages = with pkgs; [
    libertinus
  ];
}
