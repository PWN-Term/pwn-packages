TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/gcc
TERMUX_PKG_DESCRIPTION="The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and D, as well as libraries for these languages"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@hilledkinged
TERMUX_PKG_VERSION=11.1.0
TERMUX_PKG_REVISION=2
TERMUX_PKG_DEPENDS="libisl, base, libmpc, libmpfr, clang"
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/gcc/releases/download/releases/gcc-11.1.0/gcc.tar.gz
TERMUX_PKG_SHA256=697dde1eaef8365882a4f61a7ddce7393c4435f207149596dbd15ba5ddad45a4
TERMUX_PKG_BUILD_IN_SRC=true
PWN_SRC_STRIP=false

termux_step_make() {
	make
}
