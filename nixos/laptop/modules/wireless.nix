{ config, ... }:
{
    networking.wireless = {
    enable = true;
	driver = "wext"; # Make sure this is only wext, when it is nl80211 wifi does not work!

    secretsFile = "/wireless.env"; # wireless passwords in here.
	networks = {
      "Bill Wi The Science Fi" = {
        auth = ''
          key_mgmt=NONE
	    '';
	  };
      #"dominASIAN" = {
      #  auth = ''
      #    pskRaw="ext:psk_home"
	  #  '';
      #};
	  "-Valor- 6E" = {
        auth = ''
		  key_mgmt=WPA-EAP
		  eap=PEAP
		  identity="lucas.merritt@govalor.com"
		  password=ext:pass_school
		  phase1="peaplabel=0"
		  phase2="auth=MSCHAPV2"
		'';
	  };
	};
  };
}
