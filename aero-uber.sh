#!/bin/bash
export ARCH=arm
export GCC_COLORS='error=01;31:warning=01;35:note=01;36'
export CROSS_COMPILE="ccache $HOME/android/kernel/arm-eabi-6.x/bin/arm-eabi-"
echo "****************"
echo "*Cleaning up...*"
echo "****************"
make clean && make mrproper
echo "*****************"
echo "*Building now...*"
echo "*****************"
make aero_defconfig
make -j16

if [ ! -f ./arch/arm/boot/zImage-dtb ]; then 
	echo "**************************************"
	echo "*Build has failed, no zImage found...*"
	echo "**************************************"
else
	echo "*****************************************************"
	echo "*Done compiling, copying to anykernel and zipping...*"
	echo "*****************************************************"
	mv ./arch/arm/boot/zImage-dtb $HOME/android/kernel/anykernel
	cd $HOME/android/kernel/anykernel 
	mv .git $HOME/android/kernel/temp && mv README.md $HOME/android/kernel/temp
    zip -r -9 Aero-v-Uber.zip .
	mv $HOME/android/kernel/temp/.git $HOME/android/kernel/anykernel && mv $HOME/android/kernel/temp/README.md $HOME/android/kernel/anykernel
	mv Aero-v-Uber.zip $HOME/android/kernel/out && cd $HOME/android/kernel/out 
	echo "*************************"
	echo "*Done Zipping. Congrats!*"
	echo "*************************"

fi
