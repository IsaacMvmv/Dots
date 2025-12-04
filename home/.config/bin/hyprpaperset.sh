#!/bin/bash

# Set config
echo "preload = $1
wallpaper = , $1" > $HOME/.config/hypr/hyprpaper.conf

killall hyprpaper

hyprpaper &