{ config, ... }:
{
    networking.wireless = {
    enable = true;
	driver = "wext"; # Make sure this is only wext, when it is nl80211 wifi does not work!

    environmentFile = "/wireless.env"; # wireless passwords in here.
	networks = {
      "Bill Wi The Science Fi" = {
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
