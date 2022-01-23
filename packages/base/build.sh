# Forced build 1

TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/base
TERMUX_PKG_DESCRIPTION="Just for neofetch and other possible things "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=1.0.7
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/base/-/archive/master/base-master.tar.gz
TERMUX_PKG_SHA256=6d056e95fd741400ff04a924fd00a70c583b56c3497ed9800616f9c6ac5ba75e
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
