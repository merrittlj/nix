from libqtile.widget.base import _TextBox
from libqtile.widget import Wallpaper, Backlight
from libqtile.widget.backlight import ChangeDirection
from libqtile.command.base import expose_command

# This function is identical to the original change_backlight, except we round new and now to avoid floating
# point crap causing steps to not be exactly the specified percent
@expose_command()
def patched_change_backlight(self, direction, step=None):
    if not step:
        step = self.step
    if self._future and not self._future.done():
        return
    new = now = round(self._get_info() * 100) # Rounded here!
    if direction is ChangeDirection.DOWN:
        new = max(now - step, self.min_brightness)
    elif direction is ChangeDirection.UP:
        new = min(now + step, 100)
    if new != now:
        self._future = self.qtile.run_in_executor(self._change_backlight, new)

Backlight.change_backlight = patched_change_backlight
