#!/bin/bash
# This script unbinds the nvidia gpu to make it usable by the vm
# It just loads/unloads the related drivers
# If both gpus are nvidia or amd it won't work
VIDEO_ID="0000:26:00.0"
AUDIO_ID="0000:26:00.1"

# nvidia_drm always looks like is in use
# only way around it is to kill the graphical session
# even if it is not using it
vfio() {
    sudo modprobe -r nvidia_drm
    sudo modprobe -r nvidia_modeset
    sudo modprobe -r nvidia_uvm
    sudo modprobe -r nvidia
    sudo sh -c "echo -n $AUDIO_ID > /sys/bus/pci/drivers/snd_hda_intel/unbind" || echo "Failed to unbind $AUDIO_ID"

    sudo modprobe vfio-pci
}

nvidia() {
    sudo modprobe -r vfio-pci

    sudo modprobe nvidia_drm
    sudo modprobe nvidia_modeset
    sudo modprobe nvidia_uvm
    sudo modprobe nvidia

    sudo sh -c "echo -n $AUDIO_ID > /sys/bus/pci/drivers/snd_hda_intel/bind" || echo "Failed to bind $AUDIO_ID"
}

if [[ "$1" == "nvidia" ]]; then
	nvidia
elif [[ "$1" == "vfio" ]]; then
	vfio
else
	echo "parameters:
	nvidia: unbind from vfio and bind to nvidia
	vfio: unbind from nvidia and bind to vfio"
fi
