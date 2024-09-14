{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

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

    # GUI utils
    feh
    maim

    # Misc.
    home-manager
  ];
  
  fonts.packages = with pkgs; [
    libertinus
  ];
}
