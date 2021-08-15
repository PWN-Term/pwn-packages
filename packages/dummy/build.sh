TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/dummy
TERMUX_PKG_DESCRIPTION="Just a dummy package"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/dummy/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=c5429c7dc61c505b61364a77c345342f49fe8436c97ebdc0fef157e064ebfdff
# Edit me (any time)...
TERMUX_PKG_DEPENDS="base"
TERMUX_PKG_BUILD_IN_SRC=true

# ${TERMUX_PKG_DESCRIPTION} that is usable to build deps not like metapackage that makes it package but not dpe

# Also its harmless if installed

termux_step_post_make_install() {
	make install
}

