TERMUX_PKG_HOMEPAGE=http://www.mutt.org/
TERMUX_PKG_DESCRIPTION="Mail client with patches from neomutt"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.1.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=4ae6d60f7f19854c375cc1c27b5768b71e9f450c2adc10c22e45de8a27de524a
TERMUX_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, mime-support, zlib, libiconv"
TERMUX_PKG_BUILD_IN_SRC=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$TERMUX_PREFIX/bin/sh
--with-mailpath=$TERMUX_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"

if $TERMUX_DEBUG; then
	export TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="--enable-debug"
fi

TERMUX_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types.dist
"

TERMUX_PKG_CONFFILES="etc/Muttrc"

termux_step_post_configure() {
	# Build wants to run mutt_md5:
	gcc -DHAVE_STDINT_H -DMD5UTIL $TERMUX_PKG_SRCDIR/md5.c -o $TERMUX_PKG_BUILDDIR/mutt_md5
	touch -d "next hour" $TERMUX_PKG_BUILDDIR/mutt_md5
}

termux_step_post_make_install() {
	cp $TERMUX_PKG_SRCDIR/doc/mutt.man $TERMUX_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $TERMUX_PREFIX/share/examples/mutt/
	cp $TERMUX_PKG_SRCDIR/contrib/gpg.rc $TERMUX_PREFIX/share/examples/mutt/gpg.rc
}
