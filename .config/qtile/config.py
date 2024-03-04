# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#     _    _
#    / \  | | __ _ _ __  _ __      Alann Santos
#   / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
#  / ___ \| | (_| | | | | | | |
# /_/   \_\_|\__,_|_| |_|_| |_|

from typing import List

import os, random
import subprocess
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from libqtile.config import Key, Screen, Group, Drag, Click, Match

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

# Variaveis.
mod = 'mod4'  # Escolher tecla Super.
home = os.path.expanduser('~')  # Definindo caminho Home.
# Definir terminal padrão.
terminal = 'xfce4-terminal --hide-menubar --hide-toolbar'
# Papel de Parede.
wallhaven = os.path.expanduser('~') + '/.local/share/backgrounds/wallhaven/'

# Cores.
Color = [
    ['#2D353B','#2D353B'], #bg
    ['#D3C6AA','#D3C6AA'], #fg
    ['#E67E80','#E67E80'], #color01
    ['#E69875','#E69875'], #color02
    ['#DBBC7F','#DBBC7F'], #color03
    ['#A7C080','#A7C080'], #color04
    ['#83C092','#83C092'], #color05
    ['#7FBBB3','#7FBBB3'], #color06
    ['#D699B6','#D699B6'], #color07
]

keys = [
    # Controle de Som.
    Key([], 'XF86AudioRaiseVolume', lazy.spawn(
            'amixer -q -D pulse sset Master 5%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn(
            'amixer -q -D pulse sset Master 5%-')),
    Key([], 'XF86AudioMute', lazy.spawn(
            'amixer -q -D pulse sset Master toggle')),

    # Switch between windows in current stack pane
    Key([mod], 'Right', lazy.layout.down()),
    Key([mod], 'Left', lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, 'control'], 'Right', lazy.layout.shuffle_down()),
    Key([mod, 'control'], 'Left', lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    # Key([mod], 'space', lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, 'shift'], 'space', lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),
    Key([mod], 'Return', lazy.spawn(terminal)),
    Key([mod], 'Space', lazy.spawn('rofi -show drun')),
    Key([], 'Print', lazy.spawn('xfce4-screenshooter -f')),
    Key(['mod1'], 'Print', lazy.spawn('xfce4-screenshooter -r')),
    Key([mod], '1', lazy.spawn('thunar')),
    Key([mod], '2', lazy.spawn('firefox-esr')),

    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.next_layout()),
    Key([mod], 'w', lazy.window.kill()),
    Key([mod, 'control'], 'r', lazy.restart()),
    Key([mod, 'control'], 'q', lazy.shutdown()),
    Key([mod], 'r', lazy.spawncmd()),
]

groups = [
    Group('a', matches = [Match(wm_class = 'Navigator'),
                          Match(wm_class = 'Firefox-esr')]),
    Group('s', matches = [Match(wm_class = 'Steam')]),
    Group('d'),
    Group('f'),
    Group('u'),
    Group('i', matches = [Match(wm_class = 'qbittorrent'),
                          Match(wm_class = 'qBittorrent')]),
    Group('o'),
    Group('p', matches = [Match(wm_class = 'calibre-gui'),
                          Match(wm_class = 'telegram-desktop')]),
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, 'shift'], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(
        margin = 2,
        border_focus = Color[6],
        border_normal = Color[0],
    ),
    layout.Max(),
]

widget_defaults = dict(
    padding = 3,
    fontsize = 14,
    font = 'Fira Mono',
    background = Color[0],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top = bar.Bar(
            [
                widget.GroupBox(
                    disable_drag = 'true',
                    active = Color[6],
                    inactive = Color[1],
                    background = Color[0],
                    urgent_border = Color[2],
                    other_screen_border = Color[3],
                    this_current_screen_border = Color[6],
                    highlight_method = 'border',
                    borderwidth = 2,
                ),
                widget.Spacer(length = 4),
                widget.Prompt(
                    padding = 10,
                    prompt = 'Comando: ',
                    foreground = Color[1],
                    background = Color[0],
                    decorations = [
                    BorderDecoration(
                         colour = Color[8],
                         border_width = [0, 0, 2, 0],
                     )
                    ]
                ),
                widget.Spacer(length = 4),
                widget.WindowName(
                    padding = 10,
                    background = Color[6],
                    foreground = Color[0],
                    decorations = [
                    BorderDecoration(
                         colour = Color[0],
                         border_width = [2, 2, 2, 2],
                     )
                    ]
                ),
                widget.Spacer(length = 4),
                widget.Net(
                    format='{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}',
                    background = Color[0],
                    foreground = Color[3],
                    decorations = [
                    BorderDecoration(
                         colour = Color[3],
                         border_width = [0, 0, 2, 0],
                     )
                    ]
                ),
                widget.Spacer(length = 8),
                widget.Systray(
                    background = Color[0],
                    padding = 1,
                    decorations = [
                    BorderDecoration(
                         colour = Color[8],
                         border_width = [0, 0, 2, 0],
                     )
                    ]
                ),
                widget.Spacer(length = 4),
                # widget.GenPollText(
                # font = 'fira Sans',
                # fontsize = 14,
                # func = torrent,
                # update_interval = 1,
                # background = Color[1],
                # foreground = Color[1],
                # ),
                widget.Volume(
                    device = 'pulse',
                    channel = 'Master',
                    fmt = 'Vol: {}',
                    background = Color[0],
                    foreground = Color[4],
                    decorations = [
                    BorderDecoration(
                         colour = Color[4],
                         border_width = [0, 0, 2, 0],
                     )
                    ]
                ),
                widget.Spacer(length = 8),
                widget.Battery(
                    background = Color[0],
                    foreground = Color[7],
                    low_foreground = Color[2],
                    low_percentage = 0.25,
                    show_short_text = False,
                    full_char = '  ',
                    empty_char = '  ',
                    charge_char = '  ',
                    discharge_char = '  ',
                    format = '{char}  {percent:2.0%}',
                    battery = 0,
                    update_interval = 10,
                    decorations = [
                    BorderDecoration(
                         colour = Color[7],
                         border_width = [0, 0, 2, 0]
                     )
                 ],
                ),
                widget.Spacer(length = 8),
                widget.Clock(
                    background = Color[0],
                    foreground = Color[5],
                    format = '%a, %d de %b, %H:%M',
                    decorations = [
                    BorderDecoration(
                         colour = Color[5],
                         border_width = [0, 0, 2, 0]
                     )
                 ],
                ),
            ],
            26,
        ),
        wallpaper_mode='fill',
        wallpaper = wallhaven + random.choice(os.listdir(wallhaven))
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start = lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start = lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]

main = None
cursor_warp = False
bring_front_click = False
dgroups_key_binder = None
follow_mouse_focus = True
dgroups_app_rules: List = []
floating_layout = layout.Floating(
    border_width = 2,
    border_focus = Color[1],
    border_normal = Color[1],

    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class = 'maketag'),  # gitk
        Match(wm_class = 'makebranch'),  # gitk
        Match(wm_class = 'ssh-askpass'),  # ssh-askpass
        Match(wm_class = 'confirmreset'),  # gitk
        Match(title = 'pinentry'),  # GPG key password entry
        Match(title = 'branchdialog'),  # gitk
    ])
auto_fullscreen = True
focus_on_window_activation = 'smart'

# Arquivo de Autostart.
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'
