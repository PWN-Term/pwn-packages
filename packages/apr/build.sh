TERMUX_PKG_HOMEPAGE=https://apr.apache.org/
TERMUX_PKG_DESCRIPTION="Apache Portable Runtime Library"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.7.0
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://ftp.acc.umu.se/mirror/apache.org/apr/apr-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=48e9dbf45ae3fdc7b491259ffb6ccf7d63049ffacbc1c0977cced095e4c2d5a2
TERMUX_PKG_DEPENDS="libuuid"
TERMUX_PKG_BREAKS="apr-dev"
TERMUX_PKG_REPLACES="apr-dev"
TERMUX_PKG_BUILD_IN_SRC=true
# "ac_cv_search_crypt=" to avoid needlessly linking to libcrypt.
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-installbuilddir=$TERMUX_PREFIX/share/apr-1/build
ac_cv_func_getrandom=no
ac_cv_have_decl_SYS_getrandom=no
ac_cv_file__dev_zero=yes
ac_cv_func_setpgrp_void=yes
apr_cv_process_shared_works=no
apr_cv_tcp_nodelay_with_cork=yes
ac_cv_sizeof_struct_iovec=$(( TERMUX_ARCH_BITS==32 ? 8 : 16 ))
ac_cv_search_crypt="
TERMUX_PKG_RM_AFTER_INSTALL="lib/apr.exp"

termux_step_post_make_install() {
	sed -i "s%NM=\".*%NM=\"${TERMUX_HOST_PLATFORM}-nm -B\"%g" $TERMUX_PREFIX/share/apr-1/build/libtool
}
