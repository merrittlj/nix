{ inputs, config, hostname, ... }:

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

  console.keyMap = "dvorak-programmer";
  boot.initrd.kernelModules = [ "wl" ];
  
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  nixpkgs.config.allowUnfree = true;
  boot.blacklistedKernelModules = [ "b43" "ssb" "brcmfmac" "brcmsmac" "bcma" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  networking.wireless = {
    enable = true;
	driver = "wext"; # Make sure this is only wext, when it is nl80211 wifi does not work!
    networks."nixos123" = {
      auth = ''
        key_mgmt=NONE
	  '';
    };
  };
  
}
