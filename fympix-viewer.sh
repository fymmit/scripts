#!/bin/bash

search="$1"

pic=$(curl -fsS "https://api.fympix.com?search=$search" | jq -r '.[]' | shuf -n 1)

curl -fsSL "$pic" | chafa

