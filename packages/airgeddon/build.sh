TERMUX_PKG_HOMEPAGE=https://wireless.wiki.kernel.org/en/users/documentation/iw
TERMUX_PKG_DESCRIPTION="Wifite is designed to use all known methods for retrieving the password of a wireless access point (router). "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/airgeddon/-/archive/1.0.0/airgeddon-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=abc6d8895f2a704d7ff9154e82877afcced140da0cb248d9df653f1c07e27734
TERMUX_PKG_DEPENDS="aircrack-ng, python, tmux"
TERMUX_PKG_BUILD_IN_SRC=true

_PYTHON_VERSION=3.9

termux_step_make() {
	:
}
termux_step_make_install() {
	:
}

termux_step_post_make_install() {
	cp -rf airgeddon.sh ${TERMUX_PREFIX}/bin/airgeddon
	chmod +x ${TERMUX_PREFIX}/bin/airgeddon
	
	cp -rf known_pins.db ${TERMUX_PREFIX}/bin/known_pins.db
	cp -rf .airgeddonrc ${TERMUX_PREFIX}/bin/.airgeddonrc
	
	cp -rf language_strings.sh ${TERMUX_PREFIX}/bin/language_strings.sh
	chmod +x ${TERMUX_PREFIX}/bin/language_strings.sh
	
	
}
