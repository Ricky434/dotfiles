#!/bin/bash

vmName="win11"
monitorName="DP-1"
iconLocation="/home/jelly/.local/share/icons/Win11.png"
failed="false"

# Start vm
virshRes=$(virsh --connect qemu:///system start $vmName 2>&1)
if [ $? -ne 0 ]; then
    notify-send \
      -u critical -t 0 \
      -a "Win11" \
      -i $iconLocation \
      "Failed to start" "$virshRes"
    failed="true"
fi

# Show vm console
virtmRes=$(virt-manager --connect qemu:///system --show-domain-console $vmName 2>&1)
if [ $? -ne 0 ]; then
    notify-send \
      -u critical -t 0 \
      -a "Win11" \
      -i $iconLocation \
      "Failed to open console" "$virtmRes"
    failed="true"
fi

# If all went well, disable monitor
if [ "$failed" = "true" ]; then
  exit 1
fi
hyprctl keyword monitor $monitorName,disable

# Every 5 seconds check if vm is running, if it stopped reenable the monitor
running="true"
while [ "$running" = "true" ]; do
  sleep 5;

  shutoffVms=$(virsh --connect qemu:///system list --state-shutoff --name)
  echo $shutoffVms
  if echo $shutoffVms | grep -q $vmName; then
    hyprctl keyword monitor $monitorName,1920x1080,0x0,1,bitdepth,10;
    running="false";
  fi;
done
