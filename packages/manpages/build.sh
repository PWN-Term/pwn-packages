TERMUX_PKG_HOMEPAGE=https://www.kernel.org/doc/man-pages/
TERMUX_PKG_DESCRIPTION="Man pages for linux kernel and C library interfaces"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=(5.12
		    2013)
TERMUX_PKG_SHA256=(7af5c960a05a7fac56813fe5bfa564a1c280e934363ae03911b67b0b8e23371e
		   19633a5c75ff7deab35b1d2c3d5b7748e7bd4ef4ab598b647bb7e7f60b90a808)
TERMUX_PKG_SRCURL=(https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${TERMUX_PKG_VERSION}.tar.xz
		   https://www.kernel.org/pub/linux/docs/man-pages/man-pages-posix/man-pages-posix-${TERMUX_PKG_VERSION[1]}-a.tar.xz)
TERMUX_PKG_DEPENDS="man"
TERMUX_PKG_CONFLICTS="linux-man-pages"
TERMUX_PKG_REPLACES="linux-man-pages"
TERMUX_PKG_PROVIDES="linux-man-pages"
TERMUX_PKG_EXTRA_MAKE_ARGS="prefix=$TERMUX_PREFIX"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
# Problems with changing permissions of non-built files
TERMUX_MAKE_PROCESSSES=1

# man.7 and mdoc.7 is included with mandoc:
# getconf man page included with the getconf package:
# iconv-related manpages included with libiconv package:
TERMUX_PKG_RM_AFTER_INSTALL="
share/man/man1
share/man/man3/iconv.3
share/man/man3/iconv_close.3
share/man/man3/iconv_open.3
share/man/man8
share/man/man7/man.7
share/man/man7/mdoc.7
share/man/man1p/getconf.1p"


termux_step_pre_configure() {
	export TERMUX_MAKE_PROCESSES=1

	# Bundle posix man pages in same package:
	cd man-pages-posix-2013-a
	make install
}
