#!/bin/bash

pic=$(curl -fsS "https://api.fympix.com" | jq -r '.[]' | shuf -n 1)

curl -fsSL "$pic" | chafa

