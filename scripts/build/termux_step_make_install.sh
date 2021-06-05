termux_step_make_install() {
	[ "$TERMUX_PKG_METAPACKAGE" = "true" ] && return

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $TERMUX_MAKE_PROCESSES install
	elif ls ./*akefile &> /dev/null || [ -n "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
		: "${TERMUX_PKG_MAKE_INSTALL_TARGET:="install"}"
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${TERMUX_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${TERMUX_PKG_EXTRA_MAKE_ARGS} ${TERMUX_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		termux_setup_rust
		cargo install \
			--jobs $TERMUX_MAKE_PROCESSES \
			--path . \
			--force \
			--locked \
			--target $CARGO_TARGET_NAME \
			--root $TERMUX_PREFIX \
			$TERMUX_PKG_EXTRA_CONFIGURE_ARGS
		# https://github.com/rust-lang/cargo/issues/3316:
		rm -f $TERMUX_PREFIX/.crates.toml
		rm -f $TERMUX_PREFIX/.crates2.json
	fi
}
