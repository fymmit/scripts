#!/bin/bash

# Check ports with this
# pactl list sinks |& grep -E "Sink|Ports|analog-ou"

analog_stereo_sink=$(pactl list sinks short | awk '/analog-stereo/ {print $2}')
hdmi_sink=$(pactl list sinks short | awk '/hdmi/ {print $2}')

selection=$(echo -e "Headphones\nSpeakers\nHDMI\nMic toggle" | fuzzel --anchor=top-right -d --hide-prompt)

if [ "$selection" == "Headphones" ]; then
    pactl set-default-sink "$analog_stereo_sink"
    pactl set-sink-port "$analog_stereo_sink" analog-output-headphones
elif [ "$selection" == "Speakers" ]; then
    pactl set-default-sink "$analog_stereo_sink"
    pactl set-sink-port "$analog_stereo_sink" analog-output-lineout
elif [ "$selection" == "HDMI" ]; then
    pactl set-default-sink "$hdmi_sink"
elif [[ "$selection" == "Mic toggle" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    selection=""
fi

[[ -n "$selection" ]] && echo "$selection" > ~/script-data/audio_info.txt

pkill -x -RTMIN+10 waybar 2>/dev/null

