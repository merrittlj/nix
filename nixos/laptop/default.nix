{ inputs, config, hostname, ... }:

{
  imports = [
      ./packages.nix
      ./modules/bundle.nix
  ];
  
  hardware.enableAllFirmware = true;

  console.keyMap = "dvorak-programmer";
}
