TERMUX_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
TERMUX_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
TERMUX_PKG_LICENSE="NCSA"
TERMUX_PKG_MAINTAINER="@hilledkinged"
TERMUX_PKG_VERSION=21e
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/ndk-sysroot/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=b8e9abfcef15adf964e674b66cceb86e55684398d9b71574bd7ee028bcaf99cb
# This package has taken over <pty.h> from the previous libutil-dev
# and iconv.h from libandroid-support-dev:
TERMUX_PKG_CONFLICTS="libutil-dev, libandroid-support-dev"
TERMUX_PKG_REPLACES="libutil-dev, libandroid-support-dev, ndk-stl"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_post_make_install() {
	make install
}
