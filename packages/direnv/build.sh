TERMUX_PKG_HOMEPAGE=https://github.com/direnv/direnv
TERMUX_PKG_DESCRIPTION="Environment switcher for shell"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.28.0
TERMUX_PKG_SRCURL=https://github.com/direnv/direnv/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=fa539c63034b6161d8238299bb516dcec79e8905cd43ff2b9559ad6bf047cc93
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
 	termux_setup_golang
	make
}

termux_step_make_install() {
	make install PREFIX=$TERMUX_PREFIX
}
