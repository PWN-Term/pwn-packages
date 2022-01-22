# Forced builds 1

TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.4
TERMUX_PKG_REVISION=1
TERMUX_PKG_MAINTAINER=@Martinvlba
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=47904d566d6f54c47e2ae8e63a5c2b1f4e7746dd0e9185c9bbd4a1fc922f053d
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
