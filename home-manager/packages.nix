{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    mpv
    discord
    kicad
    nitrogen
    gimp
    okular
    hugo
    unstable.stm32cubemx

    programmer-calculator

    fishPlugins.grc
  ];
}
