final: prev:

{
  # Set status bar
  set_status = final.writeShellApplication {
    name = "set_status";
    runtimeInputs = with final; [ xorg.xsetroot coreutils-full ];

    # xsetroot needs a display when running in root, we use -d :0
    # iw dev spits out horizontal tabulations so we get rid of them with the "x09" sed
    # battery sed changes xy.zw to xy%
    text = final.lib.strings.concatStrings [
        "/bin/sh -c "
        "'${final.xorg.xsetroot}/bin/xsetroot -d :0 -name "
        "\""
        "$(${final.coreutils-full}/bin/date \"+%m/%d %R\")\"'"
    ];
  };
}
