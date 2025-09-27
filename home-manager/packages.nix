{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    kicad
    nitrogen
    gimp
    kdePackages.okular
    hugo
    unstable.stm32cubemx
    cura-appimage

    programmer-calculator

    fishPlugins.grc

    qbittorrent
    koodo-reader
  ];
}
