{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Desktop
    kitty
    mpv
    discord
    kicad
    qutebrowser
    firefox
    nitrogen
    gimp
    okular
    hugo
    
    python3
    python311Packages.requests
    darkhttpd
  ];
}
