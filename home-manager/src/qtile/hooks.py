import subprocess

from libqtile import hook
from qvars import *

@hook.subscribe.startup_once
def autostart():
    subprocess.check_call(str(config / "autostart.sh"), stdout=subprocess.DEVNULL)
