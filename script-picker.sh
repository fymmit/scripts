#/bin/bash

script=$(ls ~/.local/bin | fzf)

[ -z "$script" ] && exit 0

exec "$script"

