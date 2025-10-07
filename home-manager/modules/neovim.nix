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

      mouse = "a";

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
      background = "light";

      everforest_background = "soft";
	};

	plugins = {
      lightline = {
        enable = true;

        settings = { 
          colorscheme = "everforest"; 

          active = {
            left = [
              [
                "mode"
                "paste"
              ]
              [
                "readonly"
                "filename"
                "modified"
              ]
            ];
          };
        };
      };
	  autoclose.enable = true;
      nvim-surround.enable = true;
	  fugitive.enable = true;
	  commentary.enable = true;
	};

    colorschemes.everforest.enable = true;
    colorscheme = "everforest";
    
    keymaps = [
      # Use jk/kj to escape insert mode
      (mkKeymap "i" "jk" "<esc>")
      (mkKeymap "i" "kj" "<esc>")
      # Use C-l to remove search results highlight
      (mkKeymapWithOpts "n" "<C-l>" ":nohls <CR> <C-l>" { silent = true; })
      # Open files relative to the current one
      (mkKeymap "n" ",e" ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
      # Quote double quotes in current line
      (mkKeymapWithOpts "n" "qs" "0 :let hls = &hlsearch <CR> :set nohlsearch <CR> :.s#\"#\\\\\"#g <CR> :if hls | let @/ = '' | endif <CR> :let &hlsearch = hls <CR> 0" { silent = true; })
    ];
  };
}
