#!/bin/sh
#ID della gpu (video e audio)
ID1="0000:29:00.0"
ID2="0000:29:00.1"

nvidia() {
	echo "Unbind GPU from vfio driver"
	sudo sh -c "echo -n $ID1 > /sys/bus/pci/drivers/vfio-pci/unbind" || echo "Failed to unbind $ID1"
	sudo sh -c "echo -n $ID2 > /sys/bus/pci/drivers/vfio-pci/unbind" || echo "Failed to unbind $ID2"
	echo "Bind GPU to nvidia driver"
	sudo sh -c "echo -n $ID1 > /sys/bus/pci/drivers/nvidia/bind" || echo "Failed to bind $ID1"
	echo "Bind GPU audio to snd_hda_intel driver"
	sudo sh -c "echo -n $ID2 > /sys/bus/pci/drivers/snd_hda_intel/bind" || echo "Failed to bind $ID2"
}

vfio() {
	echo "Unbind GPU from nvidia driver"
	sudo sh -c "echo -n $ID1 > /sys/bus/pci/drivers/nvidia/unbind" || echo "Failed to unbind $ID1"
	echo "Bind GPU audio to snd_hda_intel driver"
	sudo sh -c "echo -n $ID2 > /sys/bus/pci/drivers/snd_hda_intel/unbind" || echo "Failed to unbind $ID2"
	echo "Bind GPU to vfio driver"
	sudo sh -c "echo -n $ID1 > /sys/bus/pci/drivers/vfio-pci/bind" || echo "Failed to bind $ID1"
	sudo sh -c "echo -n $ID2 > /sys/bus/pci/drivers/vfio-pci/bind" || echo "Failed to bind $ID2"
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
