TERMUX_PKG_HOMEPAGE=https://github.com/jbboehr/php-psr
TERMUX_PKG_DESCRIPTION="PHP extension providing the accepted PSR interfaces"
TERMUX_PKG_LICENSE="BSD Simplified"
TERMUX_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
TERMUX_PKG_VERSION=1.1.0
TERMUX_PKG_SRCURL=https://github.com/jbboehr/php-psr/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ceeaceb6424885cefd85713779fb5242ccf2274fe002f110b088297b83783ab2
TERMUX_PKG_DEPENDS=php
# php is (currently) blacklisted for x86_64. Need to blacklist
# php-psr as well for the same arch for
#   ./build-package.sh -a all -i php-psr
# to succeed
TERMUX_PKG_BLACKLISTED_ARCHES="x86_64"

termux_step_pre_configure() {
	$TERMUX_PREFIX/bin/phpize
}
