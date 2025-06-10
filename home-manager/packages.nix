{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];
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
    stm32cubemx
    unityhub
    jetbrains.idea-community
    ghidra
    flameshot
    
    python3
    python311Packages.requests
    darkhttpd
  ];
}
