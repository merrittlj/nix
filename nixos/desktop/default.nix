{ inputs, config, hostname, ... }:

{
  imports = [
      ./packages.nix
      ./modules/bundle.nix
  ];
}
