#!/bin/bash

baseurl="https://api.fympix.com"

show() {
    curl -fsSL "$1" | chafa
}

query() {
    search=$(printf "%s," "$@")
    search=${search%,}

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
    shift

    tags=$(printf "%s," "$@")
    tags=${tags%,}

    response=$(curl -fsS -F "file=@$file" -F "tags=$tags" "$baseurl" | jq -r) || {
        echo "Failed to upload"
        exit 1
    }

    echo "Uploaded:"
    show "$response"
}

if [ "$1" == "-u" ]; then
    file="$2"
    shift 2
    upload "$file" "$@"
    exit 0
fi

query "$@"

