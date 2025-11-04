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

wallpaper_loc = home / ".local/share/background.png"

def random_wallpaper(*args):
    images = [p for p in Path(wallpapers).rglob('*') if p.suffix.lower() in [".jpeg", ".jpg", ".png"]]
    selected_wallpaper = str(random.choice(images))
    # Set cache, nothing else
    subprocess.check_call(["wal", "-qnste", "-i", selected_wallpaper])
    subprocess.check_call(["ln", "-sf", selected_wallpaper, wallpaper_loc])

    qtile.reload_config()

# Load Pywal/main colors
def load_colors():
    try:
        with open(str(home / ".cache/wal/colors.json")) as wal_import:
            data = json.load(wal_import)
            wallpaper = data["wallpaper"]
            colors = data["colors"]
            val_colors = list(colors.values())
            return wallpaper, [*val_colors]
    except FileNotFoundError:
        random_wallpaper() # also reloads config
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

# Generate secondary pallete 
def secondary_pallete(colors, differentiator):
    if colors is None:
        return None

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

# must be called here and not in a startup hook: so colors are ready for other files
# colors must be set on file init and not on startup!
wallpaper, color = load_colors()
secondary_color = secondary_pallete(color, differentiator)

# wallpaper must be set on startup and not on file init!
@hook.subscribe.startup
def set_wallpaper():
    subprocess.call(["nitrogen", "--set-zoom-fill", wallpaper])
