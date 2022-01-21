TERMUX_PKG_HOMEPAGE=https://github.com/chmln/sd
TERMUX_PKG_DESCRIPTION="An intuitive find & replace CLI"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.7.6
TERMUX_PKG_SRCURL=https://github.com/chmln/sd.git
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/sd
}
