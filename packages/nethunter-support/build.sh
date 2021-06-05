TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=426c0ffa95a85558ec35b81e5658c0a187a96282acb1bf9922be194d4935eb29
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}

