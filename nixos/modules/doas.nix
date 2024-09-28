{ pkgs, ... }:
{
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }];
      extraConfig = ''
        permit nopass :wheel as root cmd "${pkgs.brightness-control}/bin/brightness-control"
        permit nopass :wheel as root cmd "${pkgs.iw}/bin/iw"
	  '';
    };
  };
}
