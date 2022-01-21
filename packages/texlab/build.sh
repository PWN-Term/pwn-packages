TERMUX_PKG_HOMEPAGE=https://texlab.netlify.app/
TERMUX_PKG_DESCRIPTION="A cross-platform implementation of the Language Server Protocol providing rich cross-editing support for the LaTeX typesetting system"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.3.1
TERMUX_PKG_SRCURL=https://github.com/latex-lsp/texlab.git
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/texlab
}
