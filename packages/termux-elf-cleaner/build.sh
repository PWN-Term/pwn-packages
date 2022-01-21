TERMUX_PKG_HOMEPAGE=https://github.com/termux/termux-elf-cleaner
TERMUX_PKG_DESCRIPTION="Cleaner of ELF files for Android"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
# NOTE: The termux-elf-cleaner.cpp file is used by
#       scripts/build/termux_step_start_build.sh
#       to create a native binary. Bumping this version will need
#       updating the checksum used there.
TERMUX_PKG_VERSION=1.10
TERMUX_PKG_SRCURL=https://github.com/termux/termux-elf-cleaner/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=022197c19129c4e57a37515bd4adcc19e05f9aa7f9ba4fbcab85a20210c39632
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_IN_SRC=true
