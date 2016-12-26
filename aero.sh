#!/bin/bash
echo "*******************************************"
echo "*Buidling Aero Kernel with both toolchains*"
echo "*******************************************"
echo "-------------------------------------------"
sleep 3
sh aero-linaro.sh && cd $HOME/android/kernel/aero-beta && sleep 3 && sh aero-uber.sh
cd ..
cd ./out
