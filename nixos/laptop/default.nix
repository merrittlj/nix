{ inputs, config, hostname, ... }:

{
  imports = [
      ./hardware.nix
      ./packages.nix
      ./modules/bundle.nix
  ];
  
  hardware.enableAllFirmware = true;

  console.keyMap = "dvorak-programmer";
}
