{ pkgs, ...}: {
  home.packages = with pkgs; [
    # Desktop
    kitty
    mpv
    discord
    kicad
    qutebrowser
    
    # WM
    ratpoison
    xclip
  ];
}
