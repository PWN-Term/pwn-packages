TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/make/
TERMUX_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=4.3
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e05fdde47c5f7ca45cb697e973894ff4f5d79e13b750ed57d7b66d8defc78e19
TERMUX_PKG_BREAKS="make-dev"
TERMUX_PKG_REPLACES="make-dev"
# Prevent linking against libelf:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"

termux_step_pre_configure() {
    if [ "$TERMUX_ARCH" = arm ]; then
	# Fix issue with make on arm hanging at least under cmake:
	# https://github.com/termux/termux-packages/issues/2983
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
    fi
}

termux_step_make() {
	# Allow to bootstrap make if building on device without make installed.
	if $TERMUX_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./build.sh
	else
		make -j $TERMUX_MAKE_PROCESSES
	fi
}

termux_step_make_install() {
	if $TERMUX_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./make -j 1 install
	else
		make -j 1 install
	fi
}
