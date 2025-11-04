import os, random, subprocess, json
from pathlib import Path
from libqtile import qtile, hook

# keys
mod_super = "mod4"
mod_alt = "mod1"

# locations
home = Path.home()
config = home / ".config/qtile"
wallpapers = home / "wallpapers"

# apps
terminal = "urxvtc"
browser = "firefox"

backend = ""
light = ""
differentiator = "222222"


def wallpaper_setter(image):
    subprocess.call(["nitrogen", "--set-zoom-fill", image])

@hook.subscribe.startup
def restore_wallpaper():
    if len(wallpaper) > 0:
        wallpaper_setter(wallpaper)

# Import colors from Pywal
with open(str(home / ".cache/wal/colors.json")) as wal_import:
    data = json.load(wal_import)
    wallpaper = data["wallpaper"]
    colors = data["colors"]
    val_colors = list(colors.values())
    def getList(val_colors):
        return [*val_colors]
      
    def init_colors():
        return [*val_colors]

color = init_colors()

# Generate secondary pallete 
def secondary_pallete(colors, differentiator):
    updated_colors = []
    for color in colors:
        # Remove the '#' symbol
        color = color.lstrip('#')
        # Convert hexadecimal colors to integers
        color_int = int(color, 16)
        differentiator_int = int(differentiator, 16)
        # Perform addition
        result_int = color_int + differentiator_int
        # Ensure the result is within the valid range of 0-FFFFFF
        result_int = min(result_int, 0xFFFFFF)
        result_int = max(result_int, 0)
        # Convert the result back to hexadecimal
        result_hex = '#' + hex(result_int)[2:].zfill(6).upper()

        updated_colors.append(result_hex)

    return updated_colors

secondary_color = secondary_pallete(color, differentiator)

def random_wallpaper(qtile):
    images = [p for p in Path(wallpapers).rglob('*') if p.suffix.lower() in [".jpeg", ".jpg", ".png"]]
    selected_wallpaper = str(random.choice(images))
    wallpaper_setter(selected_wallpaper)
    subprocess.call(["wal", "-n", "-i", selected_wallpaper, light])
    subprocess.call(["ln", "-s", selected_wallpaper, str(home / ".local/share/background.png")])

    qtile.reload_config()

