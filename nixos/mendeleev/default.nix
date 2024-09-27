{ inputs, config, hostname, ... }:

{
  imports = [
      ./hardware.nix
      ./modules/bundle.nix
  ];
}
