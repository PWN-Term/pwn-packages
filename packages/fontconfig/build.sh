TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
TERMUX_PKG_DESCRIPTION="Library for configuring and customizing font access"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.13.1
TERMUX_PKG_REVISION=6
TERMUX_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=f655dd2a986d7aa97e052261b36aa67b0a64989496361eca8d604e6414006741
TERMUX_PKG_DEPENDS="freetype, libxml2, libpng, libuuid, ttf-dejavu, zlib"
TERMUX_PKG_BREAKS="fontconfig-dev"
TERMUX_PKG_REPLACES="fontconfig-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$TERMUX_PREFIX/share/fonts
"
