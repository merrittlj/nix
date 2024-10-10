{ pkgs, lib, ... }: {
  systemd.services.xsetroot = {
    enable = true;
    description = "set xsetroot routinely";
    wantedBy = [ "graphical.target" ];
    after = [ "graphical.target" ];
    serviceConfig = {
      Type = "simple";
      User = "lucas";
      Restart = "always";
	  RestartSec = "5s";

      ExecStart = "+/bin/sh -c '${pkgs.set_status}/bin/set_status'";
    };
  };
}
