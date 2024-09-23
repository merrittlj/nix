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

    environmentFile = "/wireless.env"; # wireless passwords in here.
	networks = {
      "nixos123" = {
        auth = ''
          key_mgmt=NONE
	    '';
	  };
      "dominASIAN" = {
        auth = ''
          psk="@PSK_HOME@"
	    '';
      };
	  "-Valor- 6E" = {
        auth = ''
		  key_mgmt=WPA-EAP
		  eap=PEAP
		  identity="lucas.merritt@govalor.com"
		  password="@PSK_SCHOOL@"
		  phase1="peaplabel=0"
		  phase2="auth=MSCHAPV2"
		'';
	  };
	};
  };
}
