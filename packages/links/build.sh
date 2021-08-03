TERMUX_PKG_HOMEPAGE=http://links.twibright.com
TERMUX_PKG_DESCRIPTION="Links is a text and graphics mode WWW browser"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.23
TERMUX_PKG_SRCURL=http://links.twibright.com/download/links-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=d7118bd9781608129f4ab5e56fcac1fdeeacfa5c2f404d29cbf89daab85b951d
TERMUX_PKG_DEPENDS="brotli, libbz2, libevent, liblzma, libpng, librsvg, libtiff, libx11, openssl, zlib, zstd"
TERMUX_PKG_BUILD_DEPENDS="libxt"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$TERMUX_PREFIX/share/man
--enable-graphics
--without-openmp
"
