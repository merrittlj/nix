{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nitrogen
    gimp
    okular
    hugo
    unstable.stm32cubemx

    programmer-calculator

    fishPlugins.grc
  ];
}
