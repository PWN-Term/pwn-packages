TERMUX_PKG_HOMEPAGE=https://github.com/kaniini/libucontext
TERMUX_PKG_DESCRIPTION="A library which provides the ucontext.h C API"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.1
TERMUX_PKG_SRCURL=https://github.com/kaniini/libucontext/archive/refs/tags/libucontext-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=298201cef024aee29dfb81c3f1ef800047d5c799297651a60e2c53bb76956ea6
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="DESTDIR=$TERMUX_PREFIX"

termux_step_pre_configure() {
	TERMUX_PKG_EXTRA_MAKE_ARGS+=" ARCH=$TERMUX_ARCH"
}

termux_step_configure() {
	:
}
