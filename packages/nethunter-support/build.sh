# Forced builds 1

TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.5
TERMUX_PKG_REVISION=5
TERMUX_PKG_MAINTAINER=@Martinvlba
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=a0c7bf8290f79aca30abb6cdc5ce45ca8fea51d7985401e1b402710f57310183
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
