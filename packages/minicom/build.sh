TERMUX_PKG_HOMEPAGE=https://salsa.debian.org/minicom-team/minicom
TERMUX_PKG_DESCRIPTION="Friendly menu driven serial communication program"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.7.1
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/minicom-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=890875220458e1dd4c27ecb8cec508b06365159bfe7adb8f408a07b0a48763e9
TERMUX_PKG_DEPENDS="libiconv, ncurses"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket
--disable-music
--enable-lock-dir=$TERMUX_PREFIX/var/run
"
