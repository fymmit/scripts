#!/bin/bash

baseurl="https://api.fympix.com"

show() {
    wl-copy "$1"
    curl -fsSL "$1" | chafa
}

query() {
    search=$(echo "$1" | sed 's/ /,/g')

    echo "Searching with: $search"

    response=$(curl -fsS "$baseurl?search=$search") || {
        echo "Failed to fetch"
        exit 1
    }

    pic=$(echo "$response" | jq -r '.[]' | shuf -n 1)

    if [ -z "$pic" ]; then
        echo "No results found"
        exit 0
    fi

    show "$pic"
}

upload() {
    file="$1"
    tags=$(echo "$2" | sed 's/ /,/g')

    response=$(curl -fsS -F "file=@$file" -F "tags=$tags" "$baseurl" | jq -r) || {
        echo "Failed to upload"
        exit 1
    }

    echo "Uploaded:"
    show "$response"
}

file=""
tags=""

while getopts "u:t:" flag; do
    case "${flag}" in
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

echo "Cringe fail"

