{ inputs, config, hostname, ... }:

{
  imports = [
      ./hw.nix
      ./modules/bundle.nix
  ];
  
  hardware.enableAllFirmware = true;

  console.keyMap = "dvorak-programmer";
}
