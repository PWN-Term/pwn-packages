TERMUX_PKG_HOMEPAGE=https://profanity-im.github.io
TERMUX_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
TERMUX_PKG_VERSION=0.11.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/profanity-im/profanity/releases/download/$TERMUX_PKG_VERSION/profanity-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3fc9809816f69186dbb860b27183f6cd2aef0a52a7d14e20e4ef6c3a7f0f3606
TERMUX_PKG_DEPENDS="libandroid-support, libffi, ncurses, glib, libmesode, libcurl, readline, libuuid, libotr, gpgme, python, libassuan, libgpg-error, zlib, libsignal-protocol-c"
TERMUX_PKG_BREAKS="profanity-dev"
TERMUX_PKG_REPLACES="profanity-dev"
# openssl, libexpat needed by libmesode, pcre needed by glib:
TERMUX_PKG_BUILD_DEPENDS="openssl, libexpat, pcre, libgcrypt, libcrypt"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" --disable-python-plugins --without-xscreensaver"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	CPPFLAGS+=" -I$TERMUX_PREFIX/include/python3.9"
	LDFLAGS+=" -lpython3.9"
}

termux_step_post_configure() {
	# Enable python support manually, as trying to go using --enable-python-plugins
	# causes configure trying to execute python:
	echo '#define HAVE_PYTHON 1' >> $TERMUX_PKG_SRCDIR/src/config.h
	perl -p -i -e 's|#am__objects_2|am__objects_2|' $TERMUX_PKG_SRCDIR/Makefile
}
