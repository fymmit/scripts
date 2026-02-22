#!/bin/bash

baseurl="https://api.fympix.com"

show_help() {
    cat << EOF
Usage:
    Searching:
    fympix STRING                   (fympix "funny meme")

    Uploading:
    fympix -u STRING -t STRING      (fympix -u image.jpg -t "funny meme")
EOF
}

show() {
    wl-copy "$1"
    curl -fsSL "$1" | chafa --view-size 80x25
}

query() {
    search=$(echo "$1" | sed 's/ /,/g')

    response=$(curl -fsS "$baseurl?search=$search") || {
        echo "Failed to fetch"
        exit 1
    }

    link=$(echo "$response" | jq -r '.[]' | shuf -n 1)

    if [ -z "$link" ]; then
        echo "No results found"
        exit 0
    fi

    show "$link"
}

upload() {
    file="$1"
    tags=$(echo "$2" | sed 's/ /,/g')

    response=$(curl -fsS -F "file=@$file" -F "tags=$tags" "$baseurl" | jq -r) || {
        echo "Failed to upload"
        exit 1
    }

    path=$(realpath "$file")

    notify-send "Upload complete" "Link copied to clipboard." -i "$path" -a "fympix"
    show "$response"
}

file=""
tags=""

while getopts "hu:t:" flag; do
    case "${flag}" in
        h) show_help; exit 0 ;;
        u) file="$OPTARG" ;;
        t) tags="$OPTARG" ;;
    esac
done

if [ -n "$file" ]; then
    upload "$file" "$tags"
    exit 0
fi

if [ -z "$file" ] && [ -z "$tags" ]; then
    query "$1"
    exit 0
fi

show_help

