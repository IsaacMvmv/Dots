#!/bin/bash
wal -n -i "$@"
#    feh --bg-fill "$(< "${HOME}/.cache/wal/wal")"
$HOME/.config/bin/hyprpaperset.sh $@

# bspwm
#. "${HOME}/.cache/wal/colors.sh"
#    bspc config normal_border_color "$color3"
#    bspc config active_border_color "$color2"
#    bspc config focused_border_color "$color1"
#    bspc config presel_feedback_color "$color1"

# Firefox
pywalfox dark

# Discord
pywal-discord

# Wava
$HOME/.config/bin/wavatheme.sh

# Sublime-text
$HOME/.config/bin/pywal_sublime.py

# Dunst
#$HOME/.config/bin/launchdunst.sh

# Swaync
swaync-client --reload-config; swaync-client -rs

# Steam
#python $HOME/.config/bin/wal_steam.py -w

# GTK
cmleon

sleep 0.2

# Waybar
$HOME/.config/bin/launchwaybar.sh

#notify-send "New wallpaper set" "$@"
