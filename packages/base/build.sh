# Forced build 1

TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/base
TERMUX_PKG_DESCRIPTION="Just for neofetch and other possible things "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=1.0.7
TERMUX_PKG_REVISION=2
COMMIT_ID=126bf7ba2c1966ad8e766eb5a9b4793a5e10d19a
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/base/-/archive/$COMMIT_ID/base-$COMMIT_ID.tar.gz
TERMUX_PKG_SHA256=e110146c986d504716b391d5fa108784d4b556f5a39cf29a3ded3c35c640ccf3
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}
