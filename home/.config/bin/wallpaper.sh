#!/bin/bash

if [ $1 = "" ]; then
	wallpaper_dir="$HOME/fondos"
else
	wallpaper_dir="$1"
fi

if [ ! -d "$wallpaper_dir" ] || [ ! -r "$wallpaper_dir" ]; then
    echo "Error: Directory $wallpaper_dir does not exist or is not readable." >&2
    exit 1
fi

wallpaper=$(find "$wallpaper_dir" -type f -print0 | shuf -z -n1 | tr -d '\0')

if [ -z "$wallpaper" ]; then
    echo "Error: No files found in $wallpaper_dir." >&2
    exit 1
fi

$HOME/.config/bin/wal-tile.sh $wallpaper
