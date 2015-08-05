#!/bin/sh 
#
# Copyright (c) 2015 Alaganraj Sandhanam <alaganraj.sandhanam@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# ****************************************
# * MMC card mount point path
# ****************************************
MMC_BOOT_PATH=/media/BOOT
MMC_ROOTFS_PATH=/media/rootfs

kernel_version=4.2.0-rc3-armv7-x0

if [ ! -e ${MMC_BOOT_PATH} ]; then
echo "********************************************************"
echo "* MMC card NOT mount? or Mount point path is wrong"
echo "* Current path: ${MMC_BOOT_PATH}, ${MMC_ROOTFS_PATH}"
echo "* Edit path, if it is different"
echo "********************************************************"
exit
fi

echo "kernel_version ${kernel_version}"

sudo cp -v ./BOOT/MLO ${MMC_BOOT_PATH}/
sudo cp -v ./BOOT/u-boot.img ${MMC_BOOT_PATH}/

tar -xf ./rootfs/ubuntu-14.04.2-minimal-armhf-2015-06-09.tar.xz  -C rootfs/
sudo tar xfvp ./rootfs/ubuntu-14.04.2-minimal-armhf-2015-06-09/armhf-rootfs-ubuntu-trusty.tar -C ${MMC_ROOTFS_PATH}/

sudo cp -v ./rootfs/uEnv.txt ${MMC_ROOTFS_PATH}/boot/

sudo cp -v ./rootfs/${kernel_version}.zImage ${MMC_ROOTFS_PATH}/boot/vmlinuz-${kernel_version}
sudo mkdir -p ${MMC_ROOTFS_PATH}/boot/dtbs/${kernel_version}/
sudo tar xfv ./rootfs/${kernel_version}-dtbs.tar.gz -C ${MMC_ROOTFS_PATH}/boot/dtbs/${kernel_version}/
sudo tar xfv ./rootfs/${kernel_version}-modules.tar.gz -C ${MMC_ROOTFS_PATH}/

sudo cp -fv ./rootfs/fstab ${MMC_ROOTFS_PATH}/etc/
sudo cp -fv ./rootfs/serial.conf ${MMC_ROOTFS_PATH}/etc/init/
sudo cp -fv ./rootfs/interfaces ${MMC_ROOTFS_PATH}/etc/network/

#Instal V4L-utils 
sudo cp -v ./rootfs/v4l-utils-arm/usr/local/bin/* ${MMC_ROOTFS_PATH}/usr/local/bin/
sudo cp -v ./rootfs/v4l-utils-arm/usr/local/sbin/* ${MMC_ROOTFS_PATH}/usr/local/sbin/
sudo rsync -ar ./rootfs/v4l-utils-arm/usr/local/lib/* ${MMC_ROOTFS_PATH}/usr/local/lib/
sudo cp -v ./rootfs/v4l-utils-arm/camera-capture.sh ${MMC_ROOTFS_PATH}/home/ubuntu/

echo "Please wait..."
sync

sudo umount ${MMC_BOOT_PATH}
sudo umount ${MMC_ROOTFS_PATH}

echo "DONE !!!"
