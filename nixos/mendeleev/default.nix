{ inputs, config, hostname, ... }:

{
  imports = [
      ./packages.nix
      ./hardware.nix
      ./modules/bundle.nix
  ];
}
