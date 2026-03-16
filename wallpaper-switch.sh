#!/bin/bash

folder="$HOME/Pictures/wallpapers"

wallpapers=$(find "$folder" -type f -printf "%f\n")

selection=$(echo "$wallpapers" | fzf --preview "chafa --view-size 48x $folder/{}")

filepath="$folder/$selection"

if [ -z "$selection" ]; then
    exit 0
fi

ln -sf "$filepath" ~/Pictures/wallpaper

systemctl --user restart swaybg.service

