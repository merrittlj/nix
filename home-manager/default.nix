{ config, username, lib, nixvim, host, helpers, ... }:
let
  configPath = "/home/${username}/nix/home-manager";
  link = 
    p:
    config.lib.file.mkOutOfStoreSymlink ("${configPath}/${lib.strings.removePrefix (builtins.toString ./.) (toString p)}");
  
  linksrc =
    destination: source:
    { ${destination}.source = link source; };
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
}
