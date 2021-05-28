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

import os
import subprocess
from libqtile.command import lazy
from libqtile import qtile, layout, bar, widget, hook
from libqtile.config import Key, Screen, Group, Drag, Click, Match

# Variaveis.
mod = "mod4"  # Escolher tecla Super.
home = os.path.expanduser('~')  # Definindo caminho Home.
# Definir terminal padrão.
terminal = "xfce4-terminal --drop-down --hide-menubar --fullscreen --hide-toolbar -e 'tmux new -As0'"

# Cores.
cor1 = "#8ee269"  # Cor Principal.
cor2 = "#d3d0c8"  # Cor de Fonts.
cor3 = "#2d2d2d"  # Cor de Background.
cor4 = "#747369"  # Cor de janelas inativas.
cor5 = "#f2777a"  # Cor de Alerta.

# Cria Poll Funcion do Shell no bar com GenPollText.
# def torrent():
# return subprocess.check_output([home + "/.config/qtile/scripts/torrent"]).decode('utf-8').strip()


keys = [
    # Controle de Som.
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
            "amixer -q -D pulse sset Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
            "amixer -q -D pulse sset Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn(
            "amixer -q -D pulse sset Master toggle")),

    # Switch between windows in current stack pane
    Key([mod], "Right", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "Right", lazy.layout.shuffle_down()),
    Key([mod, "control"], "Left", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    # Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "space", lazy.spawn(
        home + "/.config/qtile/scripts/rofi-script")),
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([], "Print", lazy.spawn("xfce4-screenshooter -f")),
    Key(["mod1"], "Print", lazy.spawn("xfce4-screenshooter -r")),
    Key([mod], "1", lazy.spawn("thunar")),
    Key([mod], "2", lazy.spawn("firefox-esr")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
]

groups = [
    Group('a', matches=[Match(wm_class='Navigator'),
                        Match(wm_class='Firefox-esr')]),
    Group('s', matches=[Match(wm_class='Steam')]),
    Group('d'),
    Group('f'),
    Group('u'),
    Group('i', matches=[Match(wm_class='qbittorrent'),
                        Match(wm_class='qBittorrent')]),
    Group('o'),
    Group('p', matches=[Match(wm_class='calibre-gui'),
                        Match(wm_class='telegram-desktop')]),
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(
        border_focus=cor1,
        border_normal=cor4,
        margin=2,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font='fira sans',
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar1.png',
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/launcher.png',
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn(home + '/.config/qtile/scripts/rofi-script')},
                    background=cor3,
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar4.png',
                ),
                widget.Prompt(
                    prompt='Comando: ',
                    font='Fira Mono',
                    padding=10,
                    foreground=cor1,
                    background=cor3,
                ),
                widget.GroupBox(
                    disable_drag='true',
                    background=cor3,
                    borderwidth=2,
                    active=cor2,
                    inactive=cor1,
                    urgent_border=cor5,
                    highlight_method='border',
                    this_current_screen_border=cor1,
                    other_screen_border=cor3,
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar2.png',
                ),
                widget.WindowName(
                    font='Fira Mono',
                    padding=10,
                    foreground=cor3,
                    background=cor1,
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar3.png',
                ),
                widget.Systray(
                    background=cor3,
                    padding=1,
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar4.png',
                ),
                # widget.GenPollText(
                # font='fira Sans',
                # fontsize=14,
                # func=torrent,
                # update_interval=1,
                # background=cor3,
                # foreground=cor1,
                # ),
                widget.Volume(
                    device='pulse',
                    channel='Master',
                    background=cor3,
                    foreground=cor1,
                    emoji=True,
                ),
                widget.Battery(
                    background=cor3,
                    foreground=cor1,
                    low_foreground=cor5,
                    show_short_text=False,
                    low_percentage=0.25,
                    format=' {char} {percent:2.0%}',
                    charge_char="",
                    empty_char="",
                    discharge_char="",
                    full_char=" ",
                    battery=0,
                    update_interval=10,
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar4.png',
                ),
                widget.Clock(
                    background=cor3,
                    foreground=cor1,
                    font='Fira Mono',
                    format='%a, %d de %b, %H:%M'
                ),
                widget.Image(
                    scale=True,
                    filename='~/.config/qtile/icons/monobar5.png',
                ),
            ],
            29,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules: List = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=cor1,
    border_normal=cor4,
    border_width=2,

    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(wm_class='confirmreset'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(title='branchdialog'),  # gitk
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"

# Arquivo de Autostart.


@ hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/scripts/autostart"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
