{ pkgs, ... }:
let
  mkKeymap = mode: key: action: { inherit mode key action; };
  mkKeymapWithOpts =
    mode: key: action: opts:
    (mkKeymap mode key action) // { options = opts; };
in
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

    keymaps = [
      # Use jk/kj to escape insert mode
      (mkKeymap "i" "jk" "<esc>")
      (mkKeymap "i" "kj" "<esc>")
      # Use C-l to remove search results highlight
      (mkKeymapWithOpts "n" "<C-l>" ":nohls <CR> <C-l>" { silent = true; })
      # Open files relative to the current one
      (mkKeymap "n" ",e" ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
      (mkKeymap "n" ",t" ":tabe <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
      (mkKeymap "n" ",s" ":split <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
      # Quote double quotes in current line
      (mkKeymap "n" "qs" "0 :let hls = &hlsearch <CR> :set nohlsearch <CR> :.s#\"#\\\\\"#g <CR> :if hls | let @/ = '' | endif <CR> :let &hlsearch = hls <CR> 0")
    ];
  };
}
