#!/bin/bash

official=$(checkupdates --nocolor)
aur=$(yay -Qau)

officialcount=$(printf "%s" "$official" | grep -c '^')
aurcount=$(printf "%s" "$aur" | grep -c '^')

text="$officialcount | $aurcount"
alt="Arch:
$official
AUR:
$aur"

jq -n -c --arg text "$text" --arg alt "$alt" '{text:$text, alt:$alt}' > ~/script-data/update_info.txt

echo "$alt"

pkill -x -RTMIN+11 waybar 2>/dev/null
