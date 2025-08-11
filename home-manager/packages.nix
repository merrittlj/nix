{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nitrogen
    gimp
    kdePackages.okular
    hugo
    unstable.stm32cubemx

    programmer-calculator

    fishPlugins.grc
  ];
}
