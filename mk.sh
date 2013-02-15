#!/bin/bash
export CROSS_COMPILE=/home/none/android/toolchains/android-toolchain-eabi/bin/arm-eabi-

find ../initramfs -name ".git*" -exec rm -rf {} \;
find ../initramfs -name EMPTY_DIRECTORY -exec rm -rf {} \;
find -name '*.ko' -exec cp -av {} ../initramfs/lib/modules/ \;
chmod 644 ../initramfs/lib/modules/*
${CROSS_COMPILE}strip --strip-unneeded ../initramfs/lib/modules/*
chmod g-w ../initramfs/*.rc ../initramfs/default.prop && \

rm zImage
make clean
make -j16 arch=arm
cp arch/arm/boot/zImage zImage_in
cp -v /home/none/android/kernel/hack_stock/galaxys2_kernel_repack/recovery.cm10.tar.xz .
./mkshbootimg.py zImage zImage_in boot.img recovery.cm10.tar.xz
../../../maketar.sh

