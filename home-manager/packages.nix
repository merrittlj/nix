{ pkgs, ... }:

{
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
    bgt
    #unzip-dir

    (writeShellApplication {
      name = "test22";

      runtimeInputs = [ gnugrep ];
      text = ''
        grep test22
      '';
    })
  ];
}
