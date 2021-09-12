TERMUX_PKG_HOMEPAGE=https://gitweb.gentoo.org/proj/eudev.git
TERMUX_PKG_DESCRIPTION="eudev is Gentoo's fork of udev, systemd's device file manager for the Linux kernel. It manages device nodes in /dev and handles all user space actions when adding or removing devices."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=3.2.10
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/eudev/archive/refs/heads/3.2.10-package.tar.gz
TERMUX_PKG_SHA256=f042aa59027781052cb3dba5647c402bdcf94d4b113bd60ff39399e7dd70e4b9
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make
}

