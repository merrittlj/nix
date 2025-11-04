from libqtile import bar, layout, qtile, widget
from qvars import *

widget_defaults = dict(
    font="Fantasque Sans Mono",
    fontsize=18,
    padding=6,
)
extension_defaults = widget_defaults.copy()

host_bar = bar.Bar(
            [
                widget.CurrentLayout(),
                widget.KeyboardLayout(
                    configured_keyboards=["us", "us dvp"],
                    display_map={"us dvp": "DVP", "us": "US"},
                ),
                # wallpaper widget is unnecessary and limited
                widget.Prompt(),
                widget.WindowTabs(),
                widget.GroupBox(),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            size = 25,

            background=color[0],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
);
