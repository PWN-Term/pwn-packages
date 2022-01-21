TERMUX_PKG_HOMEPAGE=https://github.com/sytsereitsma/mdbook-plantuml
TERMUX_PKG_DESCRIPTION="mdBook preprocessor to render PlantUML code blocks as images in your book"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.7.0
TERMUX_PKG_SRCURL=https://github.com/sytsereitsma/mdbook-plantuml.git
TERMUX_PKG_DEPENDS="openssl"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$TERMUX_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$TERMUX_PREFIX/lib
}

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-plantuml
}
