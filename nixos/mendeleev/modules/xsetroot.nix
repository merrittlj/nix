{ pkgs, ... }: {
  systemd.user.services.xsetroot = {
    enable = true;
    description = "xsetroot every second";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
	  RestartSec = "5s";
      ExecStart = "/bin/sh -c '${pkgs.xorg.xsetroot}/bin/xsetroot -name \"$(${pkgs.coreutils-full}/bin/date \"+%%m/%%d %%R\")\"'";
    };
  };
}
