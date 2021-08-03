TERMUX_PKG_HOMEPAGE=https://www.pcre.org
TERMUX_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=10.37
TERMUX_PKG_SRCURL=https://ftp.pcre.org/pub/pcre/pcre2-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=4d95a96e8b80529893b4562be12648d798b957b1ba1aae39606bbc2ab956d270
TERMUX_PKG_BREAKS="pcre2-dev"
TERMUX_PKG_REPLACES="pcre2-dev"
TERMUX_PKG_RM_AFTER_INSTALL="
bin/pcre2grep
bin/pcre2test
share/man/man1/pcre2*.1
lib/libpcre2-posix.so
"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-jit
--enable-pcre2-16
--enable-pcre2-32
"
