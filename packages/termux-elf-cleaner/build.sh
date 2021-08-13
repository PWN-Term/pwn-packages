TERMUX_PKG_HOMEPAGE=https://github.com/PWN-Term/termux-elf-cleaner
TERMUX_PKG_DESCRIPTION="Cleaner of ELF files for Android"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@hilledkinged"
# NOTE: The termux-elf-cleaner.cpp file is used by build-package.sh
#       to create a native binary. Bumping this version will need
#       updating the checksum used there.
TERMUX_PKG_VERSION=1.7
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/termux-elf-cleaner/archive/master.tar.gz
TERMUX_PKG_SHA256=9f9758c948a0906224ba24f9a410f36578e4473635fa49b5329e258eaae738a8
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_IN_SRC=true
