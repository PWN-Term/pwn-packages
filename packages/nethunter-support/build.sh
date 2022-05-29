# Forced builds 1

TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.5
TERMUX_PKG_REVISION=7
TERMUX_PKG_MAINTAINER=@Martinvlba
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=1baaed420cd39d8c8899329510f0e1520d1df320c65ae45a5927b2bb2800b040
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	make compile
}

termux_step_make_install() {
	make install
}
