TERMUX_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
TERMUX_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
TERMUX_PKG_LICENSE="NCSA"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=$TERMUX_NDK_VERSION
TERMUX_PKG_REVISION=1
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_NO_STATICSPLIT=true

prepare_libs() {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
	    NDK_SUFFIX=$ARCH
	fi

	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	local BASEDIR=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$SUFFIX/${TERMUX_PKG_API_LEVEL}
	cp $BASEDIR/*.o $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,log,m}.so $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,m}.a $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/${SUFFIX}/libc++_shared.so \
		$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/${SUFFIX}/lib{c++_static,c++abi}.a \
		$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib
	echo 'INPUT(-lc++_static -lc++abi)' > $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib/libc++_shared.a

	if [ $ARCH == "x86" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/i386
	elif [ $ARCH == "arm64" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/aarch64
	else
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/$ARCH
	fi

	cp $LIBATOMIC/libatomic.a $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$SUFFIX/lib/
}

termux_step_extract_into_massagedir() {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
}
