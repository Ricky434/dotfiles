# Make vfio take over the nvidia gpu before nvidia drivers
1. Add vfio modules in mkinitcpio before nvidia as wiki says
2. Set ids of gpu that will be claimed by vfio in modprobe.d/vfio.conf
3. Rebuild initframs

No need to blacklist nvidia modules on boot

---
If virtiofs (shared filesystem) seems not to be working, even after installing all drivers
it could be that you have to enable the VirtIO-FS windows service

If network is not working, it could be blocked by your firewall. To try set FORWARD chain to accept

---
# Random crashes
- msi afterburner could cause random vm reboots
- sometimes vm crashes and pc gets stuck with some cpu cores at 100%.
    - I tried using patched gpu rom, let's see if that works -> Didn't work
    - cs2 seems to be causing it relatively often
    - It probably is the PSU -> https://forums.unraid.net/topic/135752-going-crazy-trying-to-figure-out-gpu-passthrough-stability-issues/
    Update: It WAS the PSU. It probably wasn't able to reliably and consistently deliver the watts required.
        I swapped it for a better one with the same power delivery and the problem went away


Passing through the audio part of the gpu seems to make it impossible to start the vm

Useful kernel parameters:
pci=noats # do not use pcie ats (and IOMMU device IOTLB) (dont know if I should set it or not)
pcie_aspm=off # disable pcie active state power management. Could work to prevent random vm crashes (didn't work)

---
Unrelated
resizable bar + above 4GB bla bla is actually good for performance
too bad it's not supported by my cpu (i think it is by my gpu)
also it shouldn't have impact on vm config or stability
