TERMUX_PKG_HOMEPAGE=https://github.com/sahlberg/libnfs
TERMUX_PKG_DESCRIPTION="NFS client library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=4.0.0
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://github.com/sahlberg/libnfs/archive/libnfs-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=6ee77e9fe220e2d3e3b1f53cfea04fb319828cc7dbb97dd9df09e46e901d797d
TERMUX_PKG_BREAKS="libnfs-dev"
TERMUX_PKG_REPLACES="libnfs-dev"

termux_step_pre_configure() {
	autoreconf -fi
}
