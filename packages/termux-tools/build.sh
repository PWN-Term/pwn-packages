TERMUX_PKG_HOMEPAGE=https://termux.com/
TERMUX_PKG_DESCRIPTION="Basic system tools for Termux"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.158
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_BREAKS="termux-keyring (<< 1.9)"
TERMUX_PKG_CONFLICTS="procps (<< 3.3.15-2)"

# Some of these packages are not dependencies and used only to ensure
# that core packages are installed after upgrading (we removed busybox
# from essentials).
TERMUX_PKG_DEPENDS="bzip2, coreutils, curl, dash, diffutils, findutils, gawk, grep, gzip, less, procps, psmisc, sed, tar, termux-am, termux-am-socket, termux-exec, util-linux, xz-utils, dialog"

termux_step_make_install() {

	for script in chsh dalvikvm login; do
			install -Dm700 $TERMUX_PKG_BUILDER_DIR/$script $TERMUX_PREFIX/bin/$script
			sed -i -e "s%\@TERMUX_APP_PACKAGE\@%${TERMUX_APP_PACKAGE}%g" \
				-e "s%\@TERMUX_BASE_DIR\@%${TERMUX_BASE_DIR}%g" \
				-e "s%\@TERMUX_CACHE_DIR\@%${TERMUX_CACHE_DIR}%g" \
				-e "s%\@TERMUX_HOME\@%${TERMUX_ANDROID_HOME}%g" \
				-e "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" \
				-e "s%\@PACKAGE_VERSION\@%${TERMUX_PKG_VERSION}%g" \
				-e "s%\@TERMUX_PACKAGE_FORMAT\@%${TERMUX_PACKAGE_FORMAT}%g" \
				$TERMUX_PREFIX/bin/$script
	done
}
