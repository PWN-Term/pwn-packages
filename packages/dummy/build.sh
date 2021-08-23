TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/dummy
TERMUX_PKG_DESCRIPTION="Just a dummy package"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/dummy/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=bf6bdabe1796cbafb747d84c683624a5000a6c8a0df97645911863483f00ae96
TERMUX_PKG_DEPENDS="bash, command-not-found, apt, file, patchelf, base"
TERMUX_PKG_BUILD_IN_SRC=true

# ${TERMUX_PKG_DESCRIPTION} that is usable to build deps not like metapackage that makes it package but not dpe
# Triggers
# Also its harmless if installed.

termux_step_post_make_install() {
	make install
}

