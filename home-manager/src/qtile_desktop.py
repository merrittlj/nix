from libqtile import bar, layout, qtile, widget
from libqtile.config import Screen
from qvars import *

widget_defaults = dict(
    font="Fantasque Sans Mono",
    fontsize=18,
    padding=6,
)
extension_defaults = widget_defaults.copy()

main_bar = bar.Bar(
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

            background=special_colors[0],
            foreground=special_colors[1],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
);

side_bar = bar.Bar(
            [
                widget.Prompt(),
                widget.WindowTabs(),
                widget.GroupBox(),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            size = 25,

            background=special_colors[0],
            foreground=special_colors[1],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
);

screens = [
    Screen( # Main
        bottom=main_bar, # Host-specific bar, easiest way to manage
        background="#000000",
        # DONT include wallpaper=.. here, it messes up the widget

        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen( # Side
        bottom=side_bar, # Host-specific bar, easiest way to manage
        background="#000000",
        # DONT include wallpaper=.. here, it messes up the widget

        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]
