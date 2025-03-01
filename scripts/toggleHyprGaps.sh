#!/bin/bash

current_gaps=$(hyprctl getoption general:gaps_out -j | jq ".custom")
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
    hyprctl --batch "keyword general:gaps_out $gapsOut; keyword general:gaps_in $gapsIn; keyword decoration:rounding $rounding"
else
    echo "b"
    hyprctl --batch "keyword general:gaps_out 0; keyword general:gaps_in 3; keyword decoration:rounding 0"
fi
