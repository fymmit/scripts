#!/bin/bash

selection=$(printf "Suspend\nReboot\nPower off" | fuzzel --anchor=top-right -d --hide-prompt)

case "$selection" in
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Power\ off) systemctl poweroff ;;
esac

