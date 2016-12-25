#!/bin/bash
export ARCH=arm
export GCC_COLORS='error=01;31:warning=01;35:note=01;36'
export CROSS_COMPILE="ccache $HOME/android/kernel/arm-eabi-6.x/bin/arm-eabi-"
echo "Cleaning up..."
make clean && make mrproper
echo "Building now..."
make aero_defconfig
make -j16

if [ ! -f ./arch/arm/boot/zImage-dtb ]; then 
	echo "Build has failed, no zImage found..."
else
	echo "Done compiling, copying to anykernel and zipping..."
	mv ./arch/arm/boot/zImage-dtb $HOME/android/kernel/anykernel
	cd $HOME/android/kernel/anykernel 
	mv .git $HOME/android/kernel/temp && mv README.md $HOME/android/kernel/temp
    zip -r -9 aero_v.zip .
	mv $HOME/android/kernel/temp/.git $HOME/android/kernel/anykernel && mv $HOME/android/kernel/temp/README.md $HOME/android/kernel/anykernel
	mv aero_v.zip $HOME/android/kernel/out && cd $HOME/android/kernel/out 
	echo "Done Zipping. Congrats!"

fi
