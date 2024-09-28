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
	  RestartSec = "2s";

      # xsetroot needs a display when running in root, we use -d :0
      ExecStart = lib.strings.concatStrings [
        "+/bin/sh -c "
        "'${pkgs.xorg.xsetroot}/bin/xsetroot -d :0 -name "
        "\""
        "$(${pkgs.coreutils-full}/bin/date \"+%%m/%%d %%R\") "
        \"'"];
    };
  };
}
