#!/bin/bash
while true; do
	awk '{print " " int($1/1000) "°C"}' /sys/class/hwmon/hwmon1/temp1_input
	sleep 3
done
