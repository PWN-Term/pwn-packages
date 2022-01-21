TERMUX_PKG_HOMEPAGE=https://www.spice-space.org/
TERMUX_PKG_DESCRIPTION="Implements the server side of the SPICE protocol"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.15.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://www.spice-space.org/download/releases/spice-server/spice-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=b320cf8f4bd2852750acb703c15b72856027e5a8554f8217dfbb3cc09deba0f5
TERMUX_PKG_DEPENDS="glib, libjpeg-turbo, gstreamer, gst-plugins-base, libsasl, libspice-protocol, liborc, openssl, libopus, libpixman, liblz4, zlib, libiconv"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-manual=no
--disable-tests
"
termux_step_post_make_install() {
        ln -sfr "${TERMUX_PREFIX}"/lib/libspice-server.so \
                "${TERMUX_PREFIX}"/lib/libspice-server.so.1
}
