TERMUX_PKG_HOMEPAGE=https://github.com/termux/termux-exec
TERMUX_PKG_DESCRIPTION="An execve() wrapper to make /bin and /usr/bin shebangs work"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1:0.9
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/termux-exec/archive/refs/heads/master.tar.gz
TERMUX_PKG_SHA256=956dd277949edfffeea28a64a04fb15f1aac07dee5ddf932a80a00c7c583a419
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="TERMUX_PREFIX=${TERMUX_PREFIX} TERMUX_BASE_DIR=${TERMUX_BASE_DIR}"
