TERMUX_PKG_HOMEPAGE=https://nghttp2.org/
TERMUX_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.43.0
TERMUX_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${TERMUX_PKG_VERSION}/nghttp2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f7d54fa6f8aed29f695ca44612136fa2359013547394d5dffeffca9e01a26b0f
TERMUX_PKG_BREAKS="libnghttp2-dev"
TERMUX_PKG_REPLACES="libnghttp2-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
TERMUX_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"
