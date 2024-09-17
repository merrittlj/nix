{ pkgs, ... }: {
  systemd.user.services.autorandr = {
    enable = true;
    description = "autorandr start on login";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.autorandr}/bin/autorandr --change";
    };
  };
}
