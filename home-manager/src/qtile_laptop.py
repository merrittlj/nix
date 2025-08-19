from libqtile import bar, layout, qtile, widget

widget_defaults = dict(
    font="Fantasque Sans Mono",
    fontsize=36,
    padding=6,
)
extension_defaults = widget_defaults.copy()

host_bar = bar.Bar(
            [
                widget.CurrentLayout(),
                widget.KeyboardLayout(
                    configured_keyboards=["us dvp", "us"],
                    display_map={"us dvp": "DVP", "us": "US"},
                ),
                widget.Wallpaper(
                    directory="~/wallpapers",
                    label="",
                ),
                widget.Backlight(
                    backlight_name="gmux_backlight",
                    change_command="brightnessctl set {0}%",
                ),
                widget.Battery(
                    battery="BAT0",
                ),
                widget.Wlan(
                    interface="wlp4s0",
                    format="{essid} {percent:2.0%}",
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.GroupBox(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            size = 50,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
);
