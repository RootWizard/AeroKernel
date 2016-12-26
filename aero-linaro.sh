#!/bin/bash
echo "**********************************"
echo "*Building Aero Kernel with Linaro*"
echo "**********************************"
export ARCH=arm
export GCC_COLORS='error=01;31:warning=01;35:note=01;36'
export CROSS_COMPILE="ccache $HOME/android/kernel/linaro-arm-eabi-6.x/bin/arm-eabi-"
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
	mv ./arch/arm/boot/zImage-dtb $HOME/android/kernel/anykernel-linaro
	cd $HOME/android/kernel/anykernel-linaro 
	mv .git $HOME/android/kernel/temp && mv README.md $HOME/android/kernel/temp
    zip -r -9 Aero-v-Linaro.zip .
	mv $HOME/android/kernel/temp/.git $HOME/android/kernel/anykernel-linaro && mv $HOME/android/kernel/temp/README.md $HOME/android/kernel/anykernel-linaro
	mv Aero-v-Linaro.zip $HOME/android/kernel/out 
	echo "***************"
	echo "*Done Zipping.*"
	echo "***************"
if [ -f $HOME/android/kernel/out/Aero-v-Linaro.zip ]; then
	echo "******************************"
	echo "*Found zip, successful build.*"
	echo "******************************"
else
	echo "***************************************"
	echo "*Did not find zip, unsuccessful build.*"
	echo "***************************************"
fi

fi
