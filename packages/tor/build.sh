TERMUX_PKG_HOMEPAGE=https://www.torproject.org
TERMUX_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.4.6.6
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://www.torproject.org/dist/tor-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3423189ba455372021ed44e0be576d181f2908cbd9bdef202d9c11c950882e12
TERMUX_PKG_DEPENDS="libevent, openssl, liblzma, zlib, libandroid-glob"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-zstd --disable-unittests"
TERMUX_PKG_CONFFILES="etc/tor/torrc"
TERMUX_PKG_SERVICE_SCRIPT=("tor" 'exec tor 2>&1')

termux_step_post_make_install() {
	# use default config
	mv "$TERMUX_PREFIX/etc/tor/torrc.sample" "$TERMUX_PREFIX/etc/tor/torrc"
}
