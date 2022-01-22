# Forced grep build 1

TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/grep/
TERMUX_PKG_DESCRIPTION="Command which searches one or more input files for lines containing a match to a specified pattern"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.7
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/grep/grep-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=5c10da312460aec721984d5d83246d24520ec438dd48d7ab5a05dbc0d6d6823c
TERMUX_PKG_DEPENDS="libandroid-support, pcre"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_GROUPS="base-devel"
