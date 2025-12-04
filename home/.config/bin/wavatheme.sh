#!/bin/bash

source "$HOME/.cache/wal/colors.sh"

foregroundline=$(grep -n "foreground =" "$HOME/.config/wava/config" | cut -d: -f1)
backgroundline=$(grep -n "background =" "$HOME/.config/wava/config" | cut -d: -f1)
gradient1_line=$(grep -n "gradient_color_1 =" "$HOME/.config/wava/config" | cut -d: -f1)
gradient2_line=$(grep -n "gradient_color_2 =" "$HOME/.config/wava/config" | cut -d: -f1)
gradient3_line=$(grep -n "gradient_color_3 =" "$HOME/.config/wava/config" | cut -d: -f1)

starscolor_line=$(grep -n "color =" "$HOME/.config/wava/gl/module/stars/config.ini" | cut -d: -f1)

sed -i "${foregroundline}s|.*|foreground = \"$foreground\"|" "$HOME/.config/wava/config"
sed -i "${backgroundline}s|.*|background = \"$background\"|" "$HOME/.config/wava/config"
sed -i "${gradient1_line}s|.*|gradient_color_1 = \"$color1\"|" "$HOME/.config/wava/config"
sed -i "${gradient2_line}s|.*|gradient_color_2 = \"$color4\"|" "$HOME/.config/wava/config"
sed -i "${gradient3_line}s|.*|gradient_color_3 = \"$color7\"|" "$HOME/.config/wava/config"

sed -i "${starscolor_line}s|.*| color = \"$color5\"|" "$HOME/.config/wava/gl/module/stars/config.ini"

killall wava
sleep 0.2
wava &
