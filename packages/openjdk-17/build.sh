TERMUX_PKG_HOMEPAGE=https://github.com/PojavLauncherTeam/mobile
TERMUX_PKG_DESCRIPTION="Java development kit and runtime"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=17.0
TERMUX_PKG_REVISION=10
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/mobile/archive/master.tar.gz
TERMUX_PKG_SHA256=0f394778df45cab60accef4cb2e1da6849ea17f59246108b5411ec905a3b00c5
TERMUX_PKG_DEPENDS="freetype, libandroid-shmem, libandroid-spawn, libiconv, zlib, xorgproto, libx11, libxcursor, libxext, cups, fontconfig, libpng, libxrender, libxtst, libxrandr, libxt, libxi"
TERMUX_PKG_BUILD_DEPENDS="cups, fontconfig, libpng, libx11, libxrender"
TERMUX_PKG_SUGGESTS="cups, fontconfig, libx11, libxrender"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_HAS_DEBUG=false

termux_step_pre_configure() {
	unset JAVA_HOME

	# Provide fake gcc.
	mkdir -p $TERMUX_PKG_SRCDIR/wrappers-bin
	cat <<- EOF > $TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	#!/bin/bash
	name=\$(basename "\$0")
	if [ "\$name" = "android-wrapped-clang" ]; then
		name=gcc
		compiler=$CC
	else
		name=g++
		compiler=$CXX
	fi
	if [ "\$1" = "--version" ]; then
		echo "${TERMUX_HOST_PLATFORM/arm/armv7a}-\${name} (GCC) 4.9 20140827 (prerelease)"
		echo "Copyright (C) 2014 Free Software Foundation, Inc."
		echo "This is free software; see the source for copying conditions.  There is NO"
		echo "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
		exit 0
	fi
	exec \$compiler "\${@/-fno-var-tracking-assignments/}"
	EOF
	chmod +x $TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	ln -sfr $TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang \
		$TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++
	CC=$TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	CXX=$TERMUX_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++

	cat <<- EOF > $TERMUX_STANDALONE_TOOLCHAIN/devkit.info
	DEVKIT_NAME="Android"
	DEVKIT_TOOLCHAIN_PATH="\$DEVKIT_ROOT"
	DEVKIT_SYSROOT="\$DEVKIT_ROOT/sysroot"
	EOF

	# OpenJDK uses same makefile for host and target builds, so we can't
	# easily patch usage of librt and libpthread. Using linker scripts
	# instead.
	echo 'INPUT(-lc)' > $TERMUX_PREFIX/lib/librt.so
	echo 'INPUT(-lc)' > $TERMUX_PREFIX/lib/libpthread.so
}

termux_step_configure() {
	local jdk_ldflags="-L${TERMUX_PREFIX}/lib -Wl,-rpath=$TERMUX_PREFIX/opt/openjdk/lib -Wl,--enable-new-dtags"
	bash ./configure \
		--openjdk-target=$TERMUX_HOST_PLATFORM \
		--with-extra-cflags="$CFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__TERMUX__=1" \
		--with-extra-cxxflags="$CXXFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__TERMUX__=1" \
		--with-extra-ldflags="${jdk_ldflags} -landroid-shmem -landroid-spawn" \
		--disable-precompiled-headers \
		--disable-warnings-as-errors \
		--enable-option-checking=fatal \
		--with-toolchain-type=gcc \
		--with-jvm-variants=client \
		--with-devkit="$TERMUX_STANDALONE_TOOLCHAIN" \
		--with-debug-level=release \
		--with-cups-include="$TERMUX_PREFIX/include" \
		--with-fontconfig-include="$TERMUX_PREFIX/include" \
		--with-freetype-include="$TERMUX_PREFIX/include/freetype2" \
		--with-freetype-lib="$TERMUX_PREFIX/lib" \
		--with-libpng=system \
		--with-zlib=system \
		--x-includes="$TERMUX_PREFIX/include/X11" \
		--x-libraries="$TERMUX_PREFIX/lib" \
        	--with-x="$TERMUX_PREFIX/include/X11"
}

termux_step_make() {
	cd build/linux-${TERMUX_ARCH/i686/x86}-server-release
	make JOBS=1 images

	# Delete created library stubs.
	rm $TERMUX_PREFIX/lib/librt.so $TERMUX_PREFIX/lib/libpthread.so
}

termux_step_make_install() {
	rm -rf $TERMUX_PREFIX/opt/openjdk
	mkdir -p $TERMUX_PREFIX/opt/openjdk
	cp -r build/linux-${TERMUX_ARCH/i686/x86}-server-release/images/jdk/* \
		$TERMUX_PREFIX/opt/openjdk/
	find $TERMUX_PREFIX/opt/openjdk -name "*.debuginfo" -delete

	# OpenJDK is not installed into /prefix/bin.
	local i
	for i in $TERMUX_PREFIX/opt/openjdk/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $TERMUX_PREFIX/bin/$(basename $i)
	done

	# Dependent projects may need JAVA_HOME.
	mkdir -p $TERMUX_PREFIX/etc/profile.d
	echo "export JAVA_HOME=$TERMUX_PREFIX/opt/openjdk" > \
		$TERMUX_PREFIX/etc/profile.d/java.sh

	# Symlink external dependencies.
	local l
	for l in libandroid-shmem.so libandroid-spawn.so libfreetype.so libiconv.so libz.so.1; do
		ln -sfr $TERMUX_PREFIX/lib/$l \
			$TERMUX_PREFIX/opt/openjdk/lib/$l
	done
}
