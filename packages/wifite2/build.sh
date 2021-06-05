TERMUX_PKG_HOMEPAGE=https://wireless.wiki.kernel.org/en/users/documentation/iw
TERMUX_PKG_DESCRIPTION="Wifite is designed to use all known methods for retrieving the password of a wireless access point (router). "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=2.5.8.2
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/wifite2/-/archive/2.5.8.2/wifite2-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=5279567bb267e2bde9d0ee79671bfdfbfd2a6dcdc9083fc4f8f6f5992deb576c
TERMUX_PKG_DEPENDS="aircrack-ng, python"
TERMUX_PKG_BUILD_IN_SRC=true

_PYTHON_VERSION=3.9

termux_step_make() {
	:
}
termux_step_make_install() {
	:
}

termux_step_post_make_install() {
	export PYTHONPATH=$TERMUX_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
	export CPPFLAGS+=" -I${TERMUX_PREFIX}/include/python${_PYTHON_VERSION}"
	export LDFLAGS+=" -lpython${_PYTHON_VERSION}"
	export LDSHARED="$CC -shared"
	python${_PYTHON_VERSION} setup.py install --prefix=$TERMUX_PREFIX --force
}
