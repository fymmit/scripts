#!/bin/bash

playerctl metadata --format '{{ status }}|{{ artist }} - {{ title }}' --follow | while IFS="|" read -r status song; do
    case "$status" in
        Playing) echo " $song" ;;
        *) echo "" ;;
    esac
done

