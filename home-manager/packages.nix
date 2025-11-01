{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    kicad-small
    nitrogen
    gimp
    kdePackages.okular
    hugo
    cura-appimage

    programmer-calculator

    qbittorrent
    koodo-reader

    maim

    fishPlugins.grc
    grc
  ];
}
