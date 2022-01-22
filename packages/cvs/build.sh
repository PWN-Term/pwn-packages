TERMUX_PKG_HOMEPAGE=https://www.nongnu.org/cvs/
TERMUX_PKG_DESCRIPTION="Concurrent Versions System"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1:1.12.13"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL="https://github.com/termux/distfiles/releases/download/2021.01.04/cvs-${TERMUX_PKG_VERSION:2}+real-26.tar.xz"
TERMUX_PKG_SHA256=0eda91f5e8091b676c90b2a171f24f9293acb552f4e4f77b590ae8d92a547256
TERMUX_PKG_DEPENDS="zlib, libandroid-support"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
cvs_cv_func_printf_ptr=yes
ac_cv_header_syslog_h=no
--disable-server
--with-external-zlib
"
TERMUX_PKG_RM_AFTER_INSTALL="bin/cvsbug share/man/man8/cvsbug.8"
