# Forced builds 1

TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.5
TERMUX_PKG_REVISION=3
TERMUX_PKG_MAINTAINER=@Martinvlba
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=08b4dd408135fb2934131b52db4b286af194711dd79da983bb5a96ed0d5d5268
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
