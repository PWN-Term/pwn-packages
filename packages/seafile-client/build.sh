TERMUX_PKG_HOMEPAGE=http://seafile.com
TERMUX_PKG_DESCRIPTION="Seafile is a file syncing and sharing software with file encryption and group sharing"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=8.0.3
TERMUX_PKG_SRCURL=https://github.com/haiwen/seafile/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a83d5d301cf54819ab96ea0ab53824980efdf6727460b969ce3176b4c5109f6b
TERMUX_PKG_DEPENDS="ccnet, libcurl, python"
TERMUX_PKG_BREAKS="seafile-client-dev"
TERMUX_PKG_REPLACES="seafile-client-dev"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	./autogen.sh
	export CPPFLAGS="-I$TERMUX_PKG_SRCDIR/lib $CPPFLAGS"
	export PYTHON="python3.9"
}

termux_step_post_configure() {
	#the package has trouble to prepare some headers
	cd $TERMUX_PKG_SRCDIR/lib
	python $TERMUX_PREFIX/bin/searpc-codegen.py $TERMUX_PKG_SRCDIR/lib/rpc_table.py
}
