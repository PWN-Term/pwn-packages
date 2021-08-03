TERMUX_PKG_HOMEPAGE=https://github.com/termux/proot-distro
TERMUX_PKG_DESCRIPTION="Termux official utility for managing proot'ed Linux distributions"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Leonid Pliushch <leonid.pliushch@gmail.com>"
TERMUX_PKG_VERSION=1.9.0
TERMUX_PKG_SRCURL=https://github.com/termux/proot-distro/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a4baaf11cc1325a68f6dc15610ef864c8f227b9ccd68a1e3571e1100df6a6022
TERMUX_PKG_DEPENDS="bash, bzip2, coreutils, curl, findutils, gzip, ncurses-utils, proot (>= 5.1.107-32), sed, tar, xz-utils"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

# Allow to edit distribution plug-ins.
TERMUX_PKG_CONFFILES="
etc/proot-distro/alpine.sh
etc/proot-distro/archlinux.sh
etc/proot-distro/debian-buster.sh
etc/proot-distro/fedora-33.sh
etc/proot-distro/nethunter.sh
etc/proot-distro/parrot-lts.sh
etc/proot-distro/ubuntu-18.04.sh
etc/proot-distro/ubuntu-20.04.sh
etc/proot-distro/void.sh
"

termux_step_make_install() {
	TERMUX_PREFIX="$TERMUX_PREFIX" TERMUX_ANDROID_HOME="$TERMUX_ANDROID_HOME" ./install.sh
}
