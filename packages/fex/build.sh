TERMUX_PKG_HOMEPAGE=https://wiki.fex-emu.org/index.php/Main_Page
TERMUX_PKG_DESCRIPTION="Fast x86 emulation frontend"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2201
TERMUX_PKG_SRCURL=https://github.com/FEX-Emu/FEX.git
TERMUX_PKG_GIT_BRANCH=FEX-${TERMUX_PKG_VERSION}
TERMUX_PKG_DEPENDS="libandroid-shmem, libc++"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DENABLE_LTO=OFF
-DENABLE_JEMALLOC=OFF
-DENABLE_OFFLINE_TELEMETRY=OFF
"
TERMUX_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"

	find $TERMUX_PKG_SRCDIR -name '*.h' -o -name '*.c' -o -name '*.cpp' | \
		xargs -n 1 sed -i -e 's:"/tmp:"'$TERMUX_PREFIX'/tmp:g'

	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$TERMUX_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

termux_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}

