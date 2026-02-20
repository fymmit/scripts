#!/bin/bash

search=$(printf "%s," "$@")
search=${search%,}

response=$(curl -fsS "https://api.fympix.com?search=$search") || {
    echo "Failed to fetch"
    exit 1
}

pic=$(echo "$response" | jq -r '.[]' | shuf -n 1)

if [ -z "$pic" ]; then
    echo "No results found"
    exit 0
fi

curl -fsSL "$pic" | chafa

