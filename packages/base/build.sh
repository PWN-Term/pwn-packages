TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/base
TERMUX_PKG_DESCRIPTION="Just for neofetch and other possible things "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.4
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/base/-/archive/master/base-master.tar.gz
TERMUX_PKG_SHA256=426c0ffa95a85558ec35b81e5658c0a187a96282acb1bf9922be194d4935eb29
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}

