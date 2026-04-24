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
    curtail
    gnome-decoder
    fragments
    gradia
    impression
    keypunch
    polari
    resources
    gnome-sudoku
    gnome-2048

    kdePackages.k3b
    vlc
    discord
  ];
}
