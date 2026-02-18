#!/bin/bash

channel=$1

if [ -z "$channel" ]; then
    read -p "Channel: " channel
fi

[ -z "$channel" ] && exit 0

url="https://twitch.tv/$channel"

if ! yt-dlp -j "$url" 2>/dev/null | grep -q '"is_live": true'; then
    echo "Stream offline"
    exit 0
fi

nohup streamlink "$url" best > /dev/null 2>&1 &
nohup chatterino -c "$channel" > /dev/null 2>&1 &

