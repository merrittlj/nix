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
      "FBI Surveillance Van" = {
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
	  "303CoffeeCo-5" = {
	    auth = ''
		  psk="@PSK_303COFFEE@"
		'';
	  };
      "DBBV" = {
          auth = ''
              psk="@PSK_DBBV@"
              '';
      };
      "GOOD NATURE STATION" = {
          auth = ''
              psk="@PSK_GNS@"
          '';
      };
    };
  };
  networking.firewall.extraCommands = ''
      iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 1714 -j nixos-fw-accept
      iptables -A nixos-fw -p udp --source 192.168.1.0/24 --dport 1714 -j nixos-fw-accept
      '';
}
