#!/bin/bash

while true; do
	if xhost >& /dev/null; # keep the loop running only as long as you are in a desktop session
	then
		free --mega | awk '/^Mem/ { print $3"M" }' | sed s/i//g
		sleep 3
	else break
	fi
done
