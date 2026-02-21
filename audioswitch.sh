#!/bin/bash

# Check ports with this
# pactl list sinks |& grep -E "Sink|Ports|analog-ou"

sink=$(pactl get-default-sink)

selection=$(echo -e "Headphones\nSpeakers" | fuzzel -d --hide-prompt)

if [ "$selection" == "Headphones" ]; then
    pactl set-sink-port "$sink" analog-output-headphones
elif [ "$selection" == "Speakers" ]; then
    pactl set-sink-port "$sink" analog-output-lineout
fi

pkill -x -RTMIN+10 waybar 2>/dev/null || true

