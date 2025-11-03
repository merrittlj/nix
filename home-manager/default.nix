{ config, username, lib, nixvim, host, helpers, ... }:
let
  configPath = "/home/${username}/nix/home-manager";
  link = 
    p:
    config.lib.file.mkOutOfStoreSymlink ("${configPath}/${lib.strings.removePrefix (builtins.toString ./.) (toString p)}");
  
  linksrc =
    destination: source:
    { ${destination}.source = link source; };

  # link each file in qtile/... avoid issues linking the entire dir
  qtileFiles = lib.mapAttrs' (
      name: _: lib.nameValuePair "qtile/${name}" { source = link ./src/qtile/${name}; }
  ) (lib.filterAttrs (_: type: type == "regular") (builtins.readDir ./src/qtile));
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
  xdg.configFile = 
    qtileFiles
    // (linksrc "qtile/host.py" ./src/qtile_${host}.py)
    // (linksrc "fcitx5" ./src/fcitx);
}
