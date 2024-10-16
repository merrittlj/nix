final: prev:

{
  # Set status bar
  set_status = final.writeShellApplication {
    name = "set_status";
    runtimeInputs = with final; [ xorg.xsetroot iw gnugrep gnused coreutils-full socat battery ];

    # xsetroot needs a display when running in root, we use -d :0
    # iw dev spits out horizontal tabulations so we get rid of them with the "x09" sed
    # battery sed changes xy.zw to xy%
    text = final.lib.strings.concatStrings [
        "/bin/sh -c "
        "'${final.xorg.xsetroot}/bin/xsetroot -d :0 -name "
        "\""
        "$(${final.iw}/bin/iw dev wlp4s0 link "
          "| ${final.gnugrep}/bin/grep -i ssid "
          "| ${final.gnused}/bin/sed -E \"s/(\\s*SSID:\\s)(.*)/\\\\2/\" "
          "| ${final.gnused}/bin/sed -E \"s/\\x09//g\") "
        "$(${final.iw}/bin/iw dev wlp4s0 link "
          "| ${final.gnugrep}/bin/grep -i signal "
          "| ${final.gnused}/bin/sed -E \"s/(\\s*signal:\\s)(.*)\\sdBm/\\\\2/\" "
          "| ${final.gnused}/bin/sed -E \"s/\\x09//g\") "
        "$(${final.coreutils-full}/bin/date \"+%m/%d %R\") "
        "v$(socat - UNIX-CONNECT:/tmp/volume.sock <<< \"g\") "
        "b$(${final.battery}/bin/battery "
          "| ${final.gnused}/bin/sed -E \"s/([0-9]*)\\..*/\\\\1/g\")%\"'"];
  };
}
