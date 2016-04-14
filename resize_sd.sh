#!/bin/sh
SCYL=$(sudo fdisk -l /dev/mmcblk0 | grep mmcblk0p2 | awk '{ print $2 }')
echo -e "p\nd\n2\nn\np\n2\n${SCYL}\n\n\np\nw\n" | sudo fdisk /dev/mmcblk0
sudo filetool.sh -b
sudo reboot