{ pkgs, lib, ... }:
let
  mkKeymap = mode: key: action: { inherit mode key action; };
  mkKeymapWithOpts =
    mode: key: action: opts:
    (mkKeymap mode key action) // { options = opts; };
  
  mkVimPlugin = name: owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin { inherit name; src = pkgs.fetchFromGitHub { inherit owner repo rev; hash = (if hash == null then "sha256-0000000000000000000000000000000000000000000=" else hash); }; };
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

      termguicolors = true;
      background = "dark";
	};

	plugins = {
      airline.enable = true;
	  autoclose.enable = true;
      nvim-surround.enable = true;
	  fugitive.enable = true;
	  commentary.enable = true;
	};

    extraPlugins = with pkgs.vimPlugins; [
      (mkVimPlugin "themery" "zaldih" "themery.nvim" "v2.0.0" "sha256-MbNaOIxiYmju9R+mTI+qtbwG0UNt8meNcOS5uO0pRfw=")
    ];
    
    extraConfigLua = ''
      require("themery").setup({
        -- themes = {"ayu", "catppuccin", "everforest", "gruvbox", "kanagawa", "melange", "modus", "nord", "one", "oxocarbon", "rose-pine", "tokyonight", "vscode", ...}, -- Your list of installed colorschemes.
        themes = {"ayu", "one", "oxocarbon", ... },
        livePreview = true, -- Apply theme while picking. Default to true.
      })
    '';

    colorschemes.ayu.enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.everforest.enable = true;
    colorschemes.gruvbox.enable = true;
    colorschemes.kanagawa.enable = true;
    colorschemes.melange.enable = true;
    colorschemes.modus.enable = true;
    colorschemes.nord.enable = true;
    # colorschemes.one.enable = true;
    colorschemes.oxocarbon.enable = true;
    colorschemes.rose-pine.enable = true;
    colorschemes.tokyonight.enable = true;
    colorschemes.vscode.enable = true;
    colorscheme = "ayu";
    
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
      (mkKeymapWithOpts "n" "qs" "0 :let hls = &hlsearch <CR> :set nohlsearch <CR> :.s#\"#\\\\\"#g <CR> :if hls | let @/ = '' | endif <CR> :let &hlsearch = hls <CR> 0" { silent = true; })
    ];
  };
}
