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

# *************************************************************
# *
# *    This script will partition and format the MMC card
# *
# *************************************************************

device="/dev/mmcblk0"

# Detect mmc card 
if [ ! -e ${device} ]; then
echo "mmc device NOT found!"
exit
fi

echo "************************************************************"
echo "* WARNING: THIS WILL DELETE ALL THE DATA ON $device *"
echo "* RECOMMENDED TO TAKE BACKUP COPY *"
echo "* DO IT ON YOUR OWN RISK *"
echo "************************************************************"

echo "Continue to Format $device ?[y/n]:"
read junk

if [ $junk != "y" ]; then
exit
fi

# Check mmc card already has partition, if so unmount
if [ -e ${device}p1 ]; then
	echo " "
	echo "Partition available, so unmount"

	for i in `ls -1 ${device}p?`; do
		echo " "
		echo "unmounting device '$i'"
		sudo umount $i 2>/dev/null
	done

fi

# Delete partiton by erasing partition table 
echo " "
sudo dd if=/dev/zero of=$device bs=1024 count=1024

sync

# Create partition
echo " "
echo "Creating partition..."
echo " "
cat << END | sudo fdisk $device
n
p
1

+100M
n
p
2


t
1
c
a
1
w
END

# Format partition
echo " "
echo "Formating ${device}p1..."
echo " "
sudo mkfs.vfat -F 16 ${device}p1 -n BOOT

echo " "
echo "Formating ${device}p2..."
sudo mkfs.ext4 ${device}p2 -L rootfs

echo "Success !!!"
echo "Please remove and reinsert the card "
echo " "
