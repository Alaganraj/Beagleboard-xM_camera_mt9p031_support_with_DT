# Beagleboard-xM_camera_mt9p031_support_with_DT
Beagle-xM camera(mt9p031) support with Device Tree prebuilt image

Camera module is Leopard Imaging's LI-5M03

Contents:

1. BOOT:
	Contains uboot

2. rootfs:
	Contains kernel(4.2.0-rc3), modules, device tree blob, ubuntu filesystem,
	and v4l-utils

3. partition_format_mmc.sh:
	Script to partition and format the mmc card

4. install_images.sh:
	Script to make bootable mmc card

