#!/run/current-system/sw/bin/bash

# Send info to log.txt
exec 1>/home/david/Desktop/startlog.out 2>&1

# Isolate CPUs
#systemctl set-property --runtime -- user.slice AllowedCPUs=8-15,24-31
#systemctl set-property --runtime -- system.slice AllowedCPUs=8-15,24-31
#systemctl set-property --runtime -- init.scope AllowedCPUs=8-15,24-31

#debugging
set -x

# Kill Display Manager
su -c "pidof kwin_wayland | pkill" -s /run/current-system/sw/bin/bash david
systemctl stop display-manager
systemctl stop sddm

# Sleep to let those changes apple
sleep 10

echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# uncomment the next line if you're getting a black screen
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Unload AMD and Intel Audio
modprobe -r amdgpu
modprobe -r snd_hda_intel

# Load VFIO Drivers
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1

        #su -c "pidof kwin_wayland | pkill" -s /run/current-system/sw/bin/bash david
