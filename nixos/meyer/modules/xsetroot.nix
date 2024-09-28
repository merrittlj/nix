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
      # iw dev spits out horizontal tabulations so we get rid of them with the "x09" sed
      # battery sed changes xy.zw to xy%
      ExecStart = lib.strings.concatStrings [
        "+/bin/sh -c "
        "'${pkgs.xorg.xsetroot}/bin/xsetroot -d :0 -name "
        "\""
        "$(${pkgs.iw}/bin/iw dev wlp4s0 link "
          "| ${pkgs.gnugrep}/bin/grep -i ssid "
          "| ${pkgs.gnused}/bin/sed -E \"s/(\\s*SSID:\\s)(.*)/\\\\2/\" "
          "| ${pkgs.gnused}/bin/sed -E \"s/\\x09//g\") "
        "$(${pkgs.iw}/bin/iw dev wlp4s0 link "
          "| ${pkgs.gnugrep}/bin/grep -i signal "
          "| ${pkgs.gnused}/bin/sed -E \"s/(\\s*signal:\\s)(.*)\\sdBm/\\\\2/\" "
          "| ${pkgs.gnused}/bin/sed -E \"s/\\x09//g\") "
        "$(${pkgs.coreutils-full}/bin/date \"+%%m/%%d %%R\") "
        "$(${pkgs.battery}/bin/battery "
          "| ${pkgs.gnused}/bin/sed -E \"s/([0-9]*)\\..*/\\\\1/g\")%%\"'"];
    };
  };
}
