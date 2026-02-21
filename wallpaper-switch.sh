#!/bin/bash

folder="$HOME/Pictures/wallpapers"

wallpapers=$(find "$folder" -type f -printf "%f\n")

selection=$(echo "$wallpapers" | fzf)

filepath="$folder/$selection"

if [ -z "$filepath" ]; then
    exit 0
fi

ln -sf "$filepath" ~/Pictures/wallpaper

systemctl --user restart swaybg.service

