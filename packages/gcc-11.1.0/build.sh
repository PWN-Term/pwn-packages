TERMUX_PKG_HOMEPAGE=http://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="GNU C compiler"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="its-pointless @github"
TERMUX_PKG_DEPENDS="binutils, libgmp, libmpfr, libmpc, ndk-sysroot, libisl"
TERMUX_HOST_PLATFORM="aarch64-linux-android"
TERMUX_PKG_VERSION=11.1.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/gcc/archive/refs/heads/gcc-11.1.0-ndk.tar.gz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-dependency-tracking  --disable-rpath --disable-rpath-hack --host=aarch64-linux-android --enable-languages=c,c++ --with-system-zlib"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-multilib --target=aarch64-linux-android --enable-static --with-gmp=/data/data/hilled.pwnterm/files/usr"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-mpfr=/data/data/hilled.pwnterm/files/usr"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-mpc=/data/data/hilled.pwnterm/files/usr --with-isl-include=/data/data/hilled.pwnterm/files/usr/include --with-isl-lib=/data/data/hilled.pwnterm/files/usr/lib"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-isl-version-check --disable-libssp --disable-tls --enable-lto --enable-gold=yes --enable-libatomic --program-suffix=-11 --enable-libbacktrace"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-host-shared --enable-host-libquadmath --enable-libatomic-ifuncs=no --enable-default-pie ac_cv_c_bigendian=no --with-libatomic"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-libstdcxx --enable-version-specific-runtime-libs --enable-eh-frame-hdr-for-static --disable-libmpx"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -with-gxx-include-dir=/data/data/hilled.pwnterm/files/usr/include/c++/v1 --with-arch=armv8-a --enable-fix-cortex-a53-835769"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-fix-cortex-a53-843419 --enable-libssp --disable-nls --enable-shared --prefix=/data/data/hilled.pwnterm/files/usr"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --libdir=/data/data/hilled.pwnterm/files/usr/lib --sbindir=/data/data/hilled.pwnterm/files/usr/bin --libexecdir=/data/data/hilled.pwnterm/files/usr/libexec"
TERMUX_PKG_MAINTAINER=" @its-pointless github"
TERMUX_PKG_SHA256=dd113df89575e7a45a5ef1e1a1323db86ba9b880eed6b49f04cfbd6396b012fb
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv8-a"

export AR_FOR_TARGET="aarch64-linux-android-ar"
export AS_FOR_TARGET="aarch64-linux-android-as"
export CC_FOR_TARGET="aarch64-linux-android-clang"
export CFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -Os"
export CPP_FOR_TARGET="aarch64-linux-android-clang++"
export CPPFLAGS_FOR_TARGET="-I/data/data/com.termux/files/usr/include"
export CXXFLAGS_FOR_TARGET="-specs=${TERMUX_SCRIPTDIR}/termux.spec -Os"
export CXX_FOR_TARGET="aarch64-linux-android-clang++"
export LDFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -L${TERMUX_PREFIX}/lib -Wl,-rpath-link,${TERMUX_PREFIX}lib -Wl,-rpath-link,${TERMUX_STANDALONE_TOOLCHAIN}/sysroot/usr/lib"
export LD_FOR_TARGET="aarch64-linux-android-ld"
export PKG_CONFIG_FOR_TARGET="aarch64-linux-android-pkg-config"
export RANLIB_FOR_TARGET="aarch64-linux-android-ranlib"
export FC_FOR_TARGET="aarch64-linux-android-gfortran"
export LD_FOR_BUILD="ld"

termux_step_pre_configure () {
unset LD
unset CFLAGS
unset CC
unset AR
unset CPP
unset CXXFLAGS
unset CPPFLAGS
unset RANLIB
unset FC
unset AS
unset CXX
unset LDFLAGS
}

termux_step_make () {
    # Just to be really sure that there is empty file for it
    touch /tmp/specs && rm /tmp/specs && touch /tmp/specs

    make all-gcc
}


termux_step_make_install () {
    # Just to move and test gcc out without messing up real prefix
    mkdir -p /data/gcc
    make install-gcc DESTDIR=/data/gcc
    # This will be done when it gets fully working
}

#termux_step_post_make_install () {
	# Android 5.0 only supports PIE binaries, so build that by default with a specs file:
	#local GCC_SPECS=$TERMUX_PREFIX/lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/specs
	#cp $TERMUX_SCRIPTDIR/termux.spec $GCC_SPECS
#}
