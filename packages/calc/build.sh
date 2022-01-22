TERMUX_PKG_HOMEPAGE=http://www.isthe.com/chongo/tech/comp/calc/
TERMUX_PKG_DESCRIPTION="Arbitrary precision console calculator"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.14.0.8
TERMUX_PKG_SRCURL=https://github.com/lcn2/calc/releases/download/v$TERMUX_PKG_VERSION/calc-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=ad6a2c44eeea7e06efca5384f107ffaee7564407a7474d7cd4928a53b1a28386
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="ncurses, ncurses-ui-libs, readline"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	# Fails with -j$TERMUX_MAKE_PROCESSES for some reason
	make USE_READLINE="-DUSE_READLINE" READLINE_EXTRAS="-lhistory -lncurses" \
		READLINE_LIB="-L$TERMUX_PREFIX/lib -lreadline" \
		READLINE_INCLUDE="-I$TERMUX_PREFIX/include" \
		DEFAULT_LIB_INSTALL_PATH="$TERMUX_PREFIX/lib" CC="$CC" -j1 \
		LONG_BITS=$TERMUX_ARCH_BITS
}

termux_step_make_install() {
	make T="$TERMUX_PREFIX" BINDIR="/bin" LIBDIR="/lib" INCDIR="/include" \
		SCRIPTDIR="/share/calc/cscript" CALC_SHAREDIR="/share/calc" install 
}
