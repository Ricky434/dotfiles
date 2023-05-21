#!/bin/bash

while true; do
	if xhost >& /dev/null; # keep the loop running only as long as you are in a desktop session
	then
		awk '{print "  " int($1/1000) "°C"}' /sys/class/hwmon/hwmon0/temp1_input
		sleep 3
	else break
	fi
done
