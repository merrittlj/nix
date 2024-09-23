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

    rb
    hm
    rvh
    rv
    gr
    bt
    battery
    batterylife
    batterye
    #unzip-dir
    rpbar
  ];
}
