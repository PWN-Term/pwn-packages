TERMUX_PKG_HOMEPAGE=http://bluez.org
TERMUX_PKG_DESCRIPTION="Official Linux Bluetooth protocol stack"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=5.61
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/bluez/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=4135714d51a9f17e9a7be0b9ee7187b7b0999272405f9116e2071dd744560875
TERMUX_PKG_DEPENDS="dbus, glib, json-c, libical, libsbc, eudev, cups, speexdsp"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--exec-prefix=/data/data/hilled.pwnterm/files/usr
--with-dbusconfdir=/data/data/hilled.pwnterm/files/usr/etc/dbus-1
--enable-udev
--disable-systemd
--disable-android
--enable-cups
--enable-experimental
--enable-deprecated
"
export DBUS_CONFDIR=/data/data/hilled.pwnterm/files/usr/etc/dbus-1
export PKG_CONFIG_PATH=/data/data/hilled.pwnterm/files/usr/share/pkgconfig

termux_step_post_get_source() {
	cp $TERMUX_PKG_BUILDER_DIR/{wordexp.c,wordexp.h} $TERMUX_PKG_SRCDIR/tools/
}
