from libqtile import bar, layout, qtile
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qvars import *

widget_defaults = dict(
    font="FantasqueSansM Nerd Font Mono Bold",
    fontsize=20,
    padding=6,
)
extension_defaults = widget_defaults.copy()

widgets_list = [
    # widget.CurrentLayout(),
    # widget.Prompt(),
    # widget.WindowTabs(),
    
    ## Left
    widget.Image(
        filename='~/.config/qtile/sigil.png',
        margin=2,

        # background=colors[0]
        decorations=[RectDecoration(colour=color[0], radius=7, filled=True)],
    ),

    widget.Spacer(
        length=5,
        background=transparent
    ),
    
    widget.GroupBox(
        highlight_method='block',
        rounded=True,
    
        disable_drag=True,
        use_mouse_wheel=False,

        background=colors[0]
    ),
    
    ## Middle
    widget.Spacer(length=bar.STRETCH),
    
    ## Right
    widget.PulseVolume(
        font="FantasqueSansM Nerd Font Mono",
        fontsize=36,
        emoji=True,
        # Muted, low, medium, high
        emoji_list=['','','','']
    ),
    
    widget.Clock(format="%b %d · %H:%M"),
    
    ## Not displayed
    widget.KeyboardLayout(
        configured_keyboards=["us", "us dvp"],
        # display_map={"us dvp": "DVP", "us": "US"},
        display_map={"us dvp": "", "us": ""},
    )
];

def make_bar():
    ret = bar.Bar(
        widgets_list,
        size=30,
        margin=[15,60,6,60],
        border_width=[0,0,0,0],

        background=transparent,
        foreground=special_colors[1],
    );
    return ret

screens = [
    Screen(top=make_bar()), # Main
    Screen(top=make_bar()), # Side
]
