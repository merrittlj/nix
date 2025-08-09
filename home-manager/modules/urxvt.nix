{
  programs.urxvt = {
      enable = true;
      fonts = ["xft:Fantasque Sans Mono:size=14"]
      scroll
        bar.enable = false;
        keepPosition = true;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };

      extraConfig = ''
        ! special
        URxvt.foreground: #93a1a1
        URxvt.background: #141c21
        URxvt.cursorColor: #afbfbf
        
        ! black
        URxvt.color0: #263640
        URxvt.color8: #4a697d
        
        ! red
        URxvt.color1: #d12f2c
        URxvt.color9: #fa3935
        
        ! green
        URxvt.color2: #819400
        URxvt.color10: #a4bd00
        
        ! yellow
        URxvt.color3: #b08500
        URxvt.color11: #d9a400
        
        ! blue
        URxvt.color4: #2587cc
        URxvt.color12: #2ca2f5
        
        ! magenta
        URxvt.color5: #696ebf
        URxvt.color13: #8086e8
        
        ! cyan
        URxvt.color6: #289c93
        URxvt.color14: #33c5ba
        
        ! white
        URxvt.color7: #bfbaac
        URxvt.color15: #fdf6e3

        URxvt.cursorBlink: false
        URxvt.cursorUnderline: false
      ''
  };
}
