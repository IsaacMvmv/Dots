#!/bin/bash

# Kill existing dunst instance
killall dunst
sleep 0.2

# Source pywal colors
source "$HOME/.cache/wal/colors.sh"

# Create drop-in directory if it doesn't exist
mkdir -p "$HOME/.config/dunst/dunstrc.d"

# Create dynamic color file
cat > "$HOME/.config/dunst/dunstrc.d/10-colors.conf" << EOF
[urgency_low]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color2"
    icon = "$HOME/.config/dunst/icons/low.svg"
    timeout = 0

[urgency_normal]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color5"
    icon = "$HOME/.config/dunst/icons/pokeball.svg"
    timeout = 0

[urgency_critical]
    background = "$color1"
    foreground = "$foreground"
    frame_color = "$color8"
    icon = "$HOME/.config/dunst/icons/critical.svg"
    timeout = 0
EOF

# Start dunst (will automatically load drop-in files)
dunst > /dev/null 2>&1 &