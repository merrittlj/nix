{ pkgs, lib, host, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = { 
      laptop = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "us+dvp" ])
          (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        ];
      };
      desktop = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        ];
      };
    }.${host};
  };
}
