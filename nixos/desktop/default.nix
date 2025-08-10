{ inputs, config, hostname, ... }:

{
  imports = [
      ../common.nix
      ./packages.nix
      ./modules/bundle.nix
  ];
}
