# Forced builds 1

TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/nethunter-support
TERMUX_PKG_DESCRIPTION="Adds support for nh when terminal gets called via modified nethunter-app"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.5
TERMUX_PKG_REVISION=1
TERMUX_PKG_MAINTAINER=@Martinvlba
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/nethunter-support/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=cb39bd868dc7c87435dee818855a3677bf47a4ffc32dc5bbb0efc5d884b3f779
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
