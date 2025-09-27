{ config, pkgs, ... }:

{
  services = {
    openvpn.servers = {
      riseup = {
        config = ''
          config /root/vpn/riseup-ovpn.conf
        '';
        autoStart = false;
        updateResolvConf = true;
      };
    };
  };
}
