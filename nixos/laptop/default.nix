{ inputs, config, hostname, ... }:

{
  imports = [
      ../common.nix
      ./packages.nix
      ./modules/bundle.nix
  ];
  
  hardware.enableAllFirmware = true;

  console.keyMap = "dvorak-programmer";
}
