TERMUX_PKG_HOMEPAGE=http://www.html-tidy.org/
TERMUX_PKG_DESCRIPTION="A tool to tidy down your HTML code to a clean style"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="README/LICENSE.md"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=5.8.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/htacg/tidy-html5/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=59c86d5b2e452f63c5cdb29c866a12a4c55b1741d7025cf2f3ce0cde99b0660e
TERMUX_PKG_DEPENDS="libxslt"
TERMUX_PKG_BREAKS="tidy-dev"
TERMUX_PKG_REPLACES="tidy-dev"
TERMUX_PKG_HOSTBUILD=true

termux_step_host_build() {
	## Host build required to generate man pages.
	termux_setup_cmake
	cmake "$TERMUX_PKG_SRCDIR" && make
}

termux_step_post_make_install() {
	install -Dm600 \
		"$TERMUX_PKG_HOSTBUILD_DIR"/tidy.1 \
		"$TERMUX_PREFIX"/share/man/man1/
}
