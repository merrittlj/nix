import subprocess

from libqtile import hook
from qvars import *

@hook.subscribe.startup_complete
def startup_complete_wallpaper():
    from libqtile.widget import Wallpaper
    from libqtile import qtile

    for w in qtile.widgets_map.values():
        if isinstance(w, Wallpaper):
            w.set_wallpaper()

# breaks w/ symlinks
# @hook.subscribe.startup_once
# def autostart():
    # subprocess.call(home + "/.config/qtile/autostart.sh")
