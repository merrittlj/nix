{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kicad-small
    nitrogen
    gimp
    hugo
    cura-appimage

    programmer-calculator

    qbittorrent
    koodo-reader

    maim

    fishPlugins.grc
    grc

    slack
    spotify
    libreoffice

    apostrophe
  ];
}
