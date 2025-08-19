{
  imports = [
    ./common.nix
  ];
  
  xdg.configFile = {
    "qtile/host.py".source = ./src/qtile_desktop.py;
  };
}
