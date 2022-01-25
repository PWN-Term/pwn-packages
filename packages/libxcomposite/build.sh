TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Composite extension library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.4.5
TERMUX_PKG_REVISION=20
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXcomposite-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=b3218a2c15bab8035d16810df5b8251ffc7132ff3aa70651a1fba0bfe9634e8f
TERMUX_PKG_DEPENDS="libx11, libxau, libxcb, libxdmcp"
TERMUX_PKG_BUILD_DEPENDS="libxfixes, xorgproto, xorg-util-macros"
