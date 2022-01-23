# Forced build 1

TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/base
TERMUX_PKG_DESCRIPTION="Just for neofetch and other possible things "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=1.0.7
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/base/-/archive/master/base-master.tar.gz
TERMUX_PKG_SHA256=1642107c7568cdf11b410dc5c9b23dc6a4c7e252ec4d6fbdd1473b3c4febe38b
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
