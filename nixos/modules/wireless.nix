{ config, ... }:
{
  boot.initrd.kernelModules = [ "wl" ];
  
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  nixpkgs.config.allowUnfree = true;
  boot.blacklistedKernelModules = [ "b43" "ssb" "brcmfmac" "brcmsmac" "bcma" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  networking.wireless = {
    enable = true;
	driver = "wext"; # Make sure this is only wext, when it is nl80211 wifi does not work!

    environmentFile = "/run/secrets/wireless.env"; # wireless passwords in here.
    networks."nixos123" = {
      auth = ''
        key_mgmt=NONE
	  '';
    };
    networks."dominASIAN" = {
      auth = ''
        psk="@PSK_HOME@"
	  '';
    };
  };
}
