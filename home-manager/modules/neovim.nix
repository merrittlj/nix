{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
	viAlias = true;
	vimAlias = true;

	opts = {
	  path = ".,**";

	  tabstop = 4;
	  softtabstop = 4;
	  shiftwidth = 4;
	  expandtab = true;
	  autoindent = true;

	  relativenumber = true;
	  display = "truncate";
	  wrap = false;

	  hlsearch = true;
	  incsearch = true;
	  showmatch = true;
	  syntax = "on";

	  ttimeout = true;
	  ttimeoutlen = 1;
	  ttyfast = true;

      background = "light";
	};

	plugins = {
      airline.enable = true;
	  autoclose.enable = true;
      nvim-surround.enable = true;
	  fugitive.enable = true;
	  commentary.enable = true;
	};

    extraPlugins = with pkgs.vimPlugins; [
      onehalf
    ];
    colorscheme = "onehalflight";
  };
}
