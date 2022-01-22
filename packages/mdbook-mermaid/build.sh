TERMUX_PKG_HOMEPAGE=https://github.com/badboy/mdbook-mermaid
TERMUX_PKG_DESCRIPTION="A preprocessor for mdbook to add mermaid support"
TERMUX_PKG_LICENSE="MPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.8.3
TERMUX_PKG_SRCURL=https://github.com/badboy/mdbook-mermaid.git
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-mermaid
}
