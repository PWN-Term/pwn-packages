TERMUX_PKG_HOMEPAGE=https://curl.se/
TERMUX_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=7.81.0
TERMUX_PKG_SRCURL=https://github.com/curl/curl/releases/download/curl-${TERMUX_PKG_VERSION//./_}/curl-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a067b688d1645183febc31309ec1f3cdce9213d02136b6a6de3d50f69c95a7d3
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+.\d+"
TERMUX_PKG_DEPENDS="libnghttp2, libssh2, openssl (>= 1.1.1), zlib"
TERMUX_PKG_BREAKS="libcurl-dev"
TERMUX_PKG_REPLACES="libcurl-dev"
TERMUX_PKG_ESSENTIAL=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-ntlm-wb=$TERMUX_PREFIX/bin/ntlm_auth
--with-ca-bundle=$TERMUX_PREFIX/etc/tls/cert.pem
--with-ca-path=$TERMUX_PREFIX/etc/tls/certs
--with-nghttp2
--without-libidn
--without-libidn2
--without-librtmp
--without-brotli
--with-ssl
--with-libssh2
"


# Starting with version 7.62 curl started enabling http/2 by default.
# Support for http/2 as added in version 1.4.8-8 of the apt package, so we
# conflict with previous versions to avoid broken installations.
TERMUX_PKG_CONFLICTS="apt (<< 1.4.8-8)"
