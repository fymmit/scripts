#!/bin/bash

# get_icon() {
#     case "$1" in
#         Playing) echo "" ;;
#         Paused) echo "" ;;
#         *) echo "N/A" ;;
#     esac
# }

playerctl metadata --format '{{ artist }} - {{ title }}' --follow | while read -r song; do
    status=$(playerctl status)
    echo "$song"
    # icon=$(get_icon "$status")
    # echo "$icon $song"
done

