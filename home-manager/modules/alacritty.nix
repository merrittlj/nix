{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
	settings = {
      import = [ pkgs.alacritty-theme.ayu_dark ];
      font.size = 12.0;
      font.normal.family = "Intel One Mono";

      cursor = {
        style = { shape = "Block"; blinking = "Never"; };
        vi_mode_style = { shape = "Block"; blinking = "Never"; };
      };

      window.dynamic_padding = true;
	};
  };
}
