termux_step_replace_guess_scripts() {
	[ "$TERMUX_PKG_METAPACKAGE" = "true" ] && return

	cd "$TERMUX_PKG_SRCDIR"
	find . -name config.sub -exec chmod u+w '{}' \; -exec cp "$TERMUX_SCRIPTDIR/scripts/config.sub" '{}' \;
	find . -name config.guess -exec chmod u+w '{}' \; -exec cp "$TERMUX_SCRIPTDIR/scripts/config.guess" '{}' \;
}
