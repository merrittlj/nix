{ pkgs, lib, host, ... }:
let 
  gnomeExtensions = with pkgs.gnomeExtensions; [
    wireless-hid # wireless hid battery
    window-gestures # 4-finger gestures
    appindicator # indicators on top bar
    blur-my-shell # various blurs
    clipboard-indicator # clipboard manager
  ];
in
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = { 
      laptop = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "us+dvp" ])
          (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        ];
        per-window = false;
      };
      desktop = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        ];
        per-window = false;
      };
    }.${host};

    "org/gnome/desktop/interface" = {
      enable-hot-corners = { laptop = true; desktop = false; }.${host};
      edge-tiling = true;
      color-scheme = "default";
      accent-color = "blue";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.0;
    };

    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy"; # focus follows mouse
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = (map (extension: extension.extensionUuid) gnomeExtensions);

      favorite-apps = [
        "firefox.desktop" 
        "org.gnome.Console.desktop" 
        "code-insiders.desktop" 
        "org.gnome.Nautilus.desktop" 
        "slack.desktop" 
        "org.gnome.Settings.desktop" 
      ];
    };

    "org/gnome/shell/extensions/windowgestures" = {
      three-finger = false;
      swipe4-left = 1; # minimize window
      swipe4-right = 2; # close window
      fn-move-snap = false; # no snap on moving
      swipe3-left = 0; # disable
      swipe3-right = 0; # disable
    };

    "org/gnome/desktop/session" = {
      idle-delay = 0; # "blank screen delay": never
    };

    "org/gnome/mutter" = {
      workspaces-only-on-primary = false; # workspaces on second monitor
    };
  };

  home.packages = gnomeExtensions;
}
