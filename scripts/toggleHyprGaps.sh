#!/bin/bash

current_gaps=$(hyprctl getoption general:gaps_out -j | jq ".css")
echo $current_gaps

gapsOut=$1
gapsIn=$2
rounding=$3

if [[ "$#" -ne 3 ]]; then
    echo "$0: Three arguments needed"
    exit 2
fi

if [[ $current_gaps == '"0 0 0 0"' ]]; then
    echo "a"
    hyprctl eval "hl.config({ general = { gaps_in = $gapsIn, gaps_out = $gapsOut }, decoration = { rounding = $rounding} })"
else
    echo "b"
    hyprctl eval "hl.config({ general = { gaps_in = 3, gaps_out = 0 }, decoration = { rounding = 0 } })"
fi
