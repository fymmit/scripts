#!/bin/bash

LOCATION="$1"

if [ -z "$LOCATION" ]; then
    read -p "Location: " LOCATION
    LOCATION="${LOCATION:-turku}"
fi

echo "Checking weather for $LOCATION..."

curl -sS "wttr.in/$LOCATION"

