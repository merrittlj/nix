{ lib, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "xkb" "us+dvp" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
      ];
      per-window = false;
    };

    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
    };
  };
}
