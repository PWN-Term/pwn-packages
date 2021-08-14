TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/base
TERMUX_PKG_DESCRIPTION="Just for neofetch and other possible things "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.6
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/base/-/archive/master/base-master.tar.gz
TERMUX_PKG_SHA256=ec7acaac474e54afb538ca8829a220a02401283dca85383760304372a0bfa86b
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}

