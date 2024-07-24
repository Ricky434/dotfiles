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

# Listen for shutdown event, when it happens reenable the monitor
result=$(virsh --connect qemu:///system qemu-monitor-event win11 --event SHUTDOWN --pretty --timestamp)

notify-send \
  -t 3 \
  -a "Win11" \
  -i $iconLocation \
  "Win11 shut down" "$result"

hyprctl keyword monitor $monitorName,1920x1080,0x0,1,bitdepth,10;
hyprctl dispatch closewindow title:"$vmName on QEMU/KVM"
