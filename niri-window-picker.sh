#!/bin/bash

# From:
# https://github.com/niri-wm/niri/discussions/1096#discussion-7929601

window_list=$(niri msg --json windows)
name=$(echo $window_list | jq -r '.[] | ."title"' | fuzzel --dmenu)
id=$(echo $window_list | jq -r '.[] | ."title", ."id"' | grep "$name" -x -A 1 | grep "$name" -vx)

echo $id
echo $name

niri msg action focus-window --id $id
