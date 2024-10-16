{ pkgs, lib, ... }: {
  systemd.user.services.volume-ctl = {
    enable = true;
    description = "manage volume on a user-level";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.volume-ctl}/bin/volume-ctl";
    };
  };
}
