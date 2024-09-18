{ inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./modules/bundle.nix
  ];
  
  # Hostname
  networking.hostName = "fibonacci";
  
  # Time zone.
  time.timeZone = "America/Denver";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # This is complicated, don't change
  system.stateVersion = "24.05"; 

  # boot.kernelParams = [ "nomodeset" ];
  hardware.enableAllFirmware = true;
}
