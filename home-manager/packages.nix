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
  ];
}
