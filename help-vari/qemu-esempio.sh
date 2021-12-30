#!/bin/bash
qemu-system-x86_64 \
	-boot menu=on \
	-m 8G \
	-enable-kvm \
	-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
	-smp cores=8,threads=2,sockets=1, \
	-vga virtio \
	-device qemu-xhci,id=xhci \
	-audiodev pa,id=snd0 \
	-device ich9-intel-hda \
	-device hda-output,audiodev=snd0 \
	-net nic \
	-net user,smb=/home/jelly/AltreCose/vm/shared \
	-drive file=/mnt/duck/Linux_Stuff/vm/windows_disk,format=raw \
#	-device usb-host,bus=xhci.0,hostdevice=/dev/bus/usb/001/008

#Per funzionare bisogna dargli il permesso di accedere alla porta usb a cui e' attaccata la tavoletta grafica, che per ora e' attaccata alla porta 8 (device commentato quando non la devo usare)
#Quindi fai chown a jelly su /dev/bus/usb/001/numero-porta
#RICORDA DI RIMETTERE chown root:root
