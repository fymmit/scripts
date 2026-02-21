#!/bin/bash

current=$(pactl list sinks | grep "Active Port: analog-output-" | sed 's/^.*Active Port: //')

if [ -n "$current" ]; then
    if [ "$current" == "analog-output-headphones" ]; then
        echo "Headphones"
        exit 0
    elif [ "$current" == "analog-output-lineout" ]; then
        echo "Speakers"
        exit 0
    fi
fi

echo "???"

