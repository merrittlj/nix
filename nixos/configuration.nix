{ inputs, hostname, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./packages.nix
      ./modules/bundle.nix
  ];
  
  # Hostname
  networking.hostName = "${hostname}";
  
  # Time zone.
  time.timeZone = "America/Denver";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # This is complicated, don't change
  system.stateVersion = "24.05"; 

  hardware.enableAllFirmware = true;
}
