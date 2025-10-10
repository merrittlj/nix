{
  programs.urxvt = {
      enable = true;
      fonts = ["xft:Fantasque Sans Mono:size=14"];
      scroll = {
        bar.enable = false;
        keepPosition = true;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };

      extraConfig = {
        # Special
        foreground = "#5c6a72";
        background = "#f3ead3";
        cursorColor = "#5c6a72";
        pointerColorBackground = "#f3ead3";
        pointerColorForeground = "#5c6a72";

        # Black
        color0 = "#708089";
        color8 = "#829181";

        # Red
        color1 = "#f85552";
        color9 = "#e66868";

        # Green
        color2 = "#8da101";
        color10 = "#93b259";

        # Yellow
        color3 = "#dfa000";
        color11 = "#dfa000";

        # Blue
        color4 = "#3a94c5";
        color12 = "#3a94c5";

        # Magenta
        color5 = "#df69ba";
        color13 = "#df69ba";

        # Cyan
        color6 = "#35a77c";
        color14 = "#35a77c";

        # White
        color7 = "#939f91";
        color15 = "#a6b0a0";

        # Cursor behavior
        cursorBlink = "false";
        cursorUnderline = "false";
    };
  };
}
