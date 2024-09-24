{ inputs, config, hostname, ... }:

{
  imports = [
      ./hw.nix
      ./modules/bundle.nix
  ];
}
