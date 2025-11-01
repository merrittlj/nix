{ config, username, lib, nixvim, host, helpers, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./packages.nix
    nixvim.homeModules.nixvim
  ] ++ (import ./bundle.nix { inherit host helpers; });
  
  news.display = "silent";
  home = {
  	username = "${username}";
  	homeDirectory = "/home/${username}";
  	stateVersion = "24.05";
  };
  xdg.configFile = {
    "qtile" = {
      # source = link ./src/qtile;
      source = ./src/qtile;
      recursive = true;
    };
    "qtile/host.py".source = link ./src/qtile_${host}.py;
  
    "fcitx5".source = link ./src/fcitx5;
  };
}
