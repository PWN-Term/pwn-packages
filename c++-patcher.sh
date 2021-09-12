#/bin/bash

# source this as of ndk version string
source scripts/properties.sh

FILE=/data/data/.built-packages/libc++
if [ -f $FILE ]; then

    # Delete old headers of ndk c++
    echo "[*]: Deleting old headers"
    rm -rf $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/include/c++/v1/*

    # Copy over new ones to $TERMUX_STANDALONE_TOOLCHAIN
    echo "[*]: Plaching new headers from ' ${TERMUX_PREFIX/include/c++/v1/}' to ' /home/builder/.termux-build/_cache/android-r${TERMUX_NDK_VERSION_NUM}${TERMUX_NDK_REVISION}-api-24-v4/sysroot/usr/include/c++/v1' "

    cp -rf $TERMUX_PREFIX/include/c++/v1/* /home/builder/.termux-build/_cache/android-r${TERMUX_NDK_VERSION_NUM}${TERMUX_NDK_REVISION}-api-28-v4/sysroot/usr/include/c++/v1/

    echo "[*]: Headers patched..."
else
    echo " "
    echo "File $FILE does not exist. Please build libc++ before using this patch."
    echo "Example: ./build-package.sh libc++"
fi
