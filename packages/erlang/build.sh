TERMUX_PKG_HOMEPAGE=https://www.erlang.org/
TERMUX_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=24.2
TERMUX_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=0b9c9ba7d8b40f6c77d529e07561b10f0914d2bfe9023294d7eda85b62936792
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_AUTO_UPDATE_TAG_REGEXP="\d+(\.\d+)+"
TERMUX_PKG_DEPENDS="openssl, ncurses, zlib"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--without-javac
--with-ssl=${TERMUX_PREFIX}
--with-termcap
erl_xcomp_sysroot=${TERMUX_PREFIX}
"

termux_step_post_get_source() {
	# We need a host build every time, because we dont know the full output of host build and have no idea to cache it.
	rm -Rf "$TERMUX_PKG_HOSTBUILD_DIR"
}

termux_step_host_build() {
	cd $TERMUX_PKG_BUILDDIR
	# Erlang cross compile reference: https://github.com/erlang/otp/blob/master/HOWTO/INSTALL-CROSS.md#building-a-bootstrap-system
	# Build erlang bootstrap system.
	./configure --enable-bootstrap-only --without-javac --without-ssl --without-termcap
	make -j $TERMUX_MAKE_PROCESSES
}

termux_step_pre_configure() {
	# Add --build flag for erlang cross build
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$(./erts/autoconf/config.guess)"
}