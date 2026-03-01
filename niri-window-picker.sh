#!/bin/bash

# From:
# https://github.com/niri-wm/niri/discussions/1096#discussion-7929601

window_list=$(niri msg --json windows)
name=$(echo $window_list | jq -r '.[] | ."title"+" | "+."app_id"' | fuzzel --dmenu)
id=$(echo $window_list | jq -r '.[] | ."title"+" | "+."app_id", ."id"' | grep "$name" -x -A 1 | grep "$name" -vx)

if [[ -z "$id" ]] && [[ -n "$name" ]]; then
    fuzzel --search="$name" --auto-select
else
    niri msg action focus-window --id $id
fi
