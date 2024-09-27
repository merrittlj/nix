{ inputs, config, hostname, ... }:

{
  imports = [
      ./hardware.nix
      ./modules/bundle.nix
  ];
  
  hardware.enableAllFirmware = true;

  console.keyMap = "dvorak-programmer";
}
