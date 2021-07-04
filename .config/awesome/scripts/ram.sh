#!/bin/bash
while true; do
	free --mega | awk '/^Mem/ { print $3"M" }' | sed s/i//g
	sleep 3
done
