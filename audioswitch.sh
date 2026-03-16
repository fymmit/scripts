#!/bin/bash

# Check ports with this
# pactl list sinks |& grep -E "Sink|Ports|analog-ou"

sink=$(pactl get-default-sink)

selection=$(echo -e "Headphones\nSpeakers\nMic toggle" | fuzzel --anchor=top-right -d --hide-prompt)

if [ "$selection" == "Headphones" ]; then
    pactl set-sink-port "$sink" analog-output-headphones
elif [ "$selection" == "Speakers" ]; then
    pactl set-sink-port "$sink" analog-output-lineout
elif [[ "$selection" == "Mic toggle" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    selection=""
fi

[[ -n "$selection" ]] && echo "$selection" > ~/script-data/audio_info.txt

pkill -x -RTMIN+10 waybar 2>/dev/null

