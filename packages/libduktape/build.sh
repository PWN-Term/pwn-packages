TERMUX_PKG_HOMEPAGE=https://www.duktape.org/
TERMUX_PKG_DESCRIPTION="An embeddable Javascript engine with a focus on portability and compact footprint"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_SRCURL=https://github.com/svaarala/duktape.git
TERMUX_PKG_VERSION=2.6.0
TERMUX_PKG_REPLACES="duktape (<< 2.3.0-1), libduktape-dev"
TERMUX_PKG_BREAKS="duktape (<< 2.3.0-1), libduktape-dev"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	if $TERMUX_ON_DEVICE_BUILD; then
		# configure.py requires 'yaml' python2 module.
		if ! pip2 show pyyaml > /dev/null 2>&1; then
			pip2 install pyyaml
		fi
	fi
}

termux_step_make() {
	make libduktape.so.1.0.0 duk CC=${CC} GXX=${CXX}
}

termux_step_make_install() {
	install libduktape.so.1.0.0 ${TERMUX_PREFIX}/lib/libduktape.so
	install duk ${TERMUX_PREFIX}/bin
	install prep/nondebug/*.h ${TERMUX_PREFIX}/include
}

termux_step_post_make_install() {
	# Add a pkg-config file for the duktape lib
	cat > "$PKG_CONFIG_LIBDIR/duktape.pc" <<-HERE
		Name: Duktape
		Description: Shared library for the Duktape interpreter
		Version: $TERMUX_PKG_VERSION
		Requires:
		Libs: -lduktape -lm
	HERE
}
