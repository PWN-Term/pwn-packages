##
##  Requires OpenCL support in your OS.
##

TERMUX_PKG_HOMEPAGE=https://hashcat.net/hashcat
TERMUX_PKG_DESCRIPTION="World's fastest and most advanced password recovery utility"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Leonid Pliushch <leonid.pliushch@gmail.com>"
TERMUX_PKG_VERSION=5.1.0
TERMUX_PKG_REVISION=9
TERMUX_PKG_SRCURL=https://github.com/hashcat/hashcat/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=283beaa68e1eab41de080a58bb92349c8e47a2bb1b93d10f36ea30f418f1e338
TERMUX_PKG_DEPENDS="libiconv"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

termux_step_pre_configure() {
	CFLAGS+="-isystem $TERMUX_PKG_BUILDER_DIR/include $CPPFLAGS"
	LDFLAGS+=" -liconv"
}

termux_step_post_make_install() {
	mkdir -p "$TERMUX_PREFIX"/libexec
	mv -f "$TERMUX_PREFIX"/bin/hashcat \
		"$TERMUX_PREFIX"/libexec/
	install -Dm700 "$TERMUX_PKG_BUILDER_DIR"/hashcat.sh \
		"$TERMUX_PREFIX"/bin/hashcat
	sed -i "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" \
		"$TERMUX_PREFIX"/bin/hashcat
}

termux_step_install_license() {
	install -Dm600 -t "$TERMUX_PREFIX/share/doc/hashcat" \
		"$TERMUX_PKG_SRCDIR"/docs/license.txt
}
