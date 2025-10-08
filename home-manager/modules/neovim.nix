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
	};

	globals = {
      everforest_background = "soft";
	};

	plugins = {
      lualine = {
        enable = true;

        settings = { 
          theme = "everforest"; 
        };
      };
	  fugitive.enable = true;
	  commentary.enable = true;

	  treesitter = {
	    enable = true;
	    
	    settings = {
	      highlight.enable = true;
	    };
	  };
	};

    extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
      name = "everforest";
      src = pkgs.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "d2936185a6d266def29fd7b523d296384580ef08";
        hash = "sha256-nOMUb55P5mqUKD5w5xppJ94+gGnZbllJBoAiQLFFLA0=";
      };
    })];

    colorscheme = "everforest";
    
    keymaps = [
      # Use jk/kj to escape insert mode
      (mkKeymap "i" "jk" "<esc>")
      (mkKeymap "i" "kj" "<esc>")
      # Use C-l to remove search results highlight
      (mkKeymapWithOpts "n" "<C-l>" ":nohls <CR> <C-l>" { silent = true; })
      # Open files relative to the current one
      (mkKeymap "n" ",e" ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
    ];
  };
}
