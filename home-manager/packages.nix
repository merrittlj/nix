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
    unstable.stm32cubemx

    programmer-calculator

    python3
    python311Packages.requests
    python311Packages.pypng
    darkhttpd
  ];
}
