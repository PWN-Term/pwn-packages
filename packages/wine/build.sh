TERMUX_PKG_HOMEPAGE=https://dl.winehq.org/
TERMUX_PKG_DESCRIPTION="Run Windows applications on Linux, BSD, Solaris and Mac OS X."
TERMUX_PKG_LICENSE="GPL-2.1"
TERMUX_PKG_VERSION=6.11
TERMUX_PKG_REVISION=1
TERMUX_PkG_MAINTAINER=@hilledkinged
TERMUX_PKG_SRCURL=https://github.com/PWN-Term/wine/archive/refs/heads/pwn.tar.gz
TERMUX_PKG_SHA256=ccc995216cfe6eb1ec4aa1fc8af446fca62a4d237e31dbebbb2b0938f740a674
TERMUX_PKG_DEPENDS="xorgproto, libx11, build-essential, libandroid-shmem, libxcursor, libxext, fontconfig, libpng, libxrender, libxtst, libxrandr, libxt, libxi, fontconfig"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-tests --enable-win64 --with-x --x-include=/data/data/hilled.pwnterm/files/usr/include --x-libraries=/data/data/hilled.pwnterm/files/usr/lib"
TERMUX_PKG_BUILD_IN_SRC=true

# Disable some things like .apk creation
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
enable_wineandroid_drv=no
--with-wine-tools=/usr/bin/wine
"

termux_step_make() {
# Test compile
make -C dlls/winex11.drv

# If test compile has finished then finish the compile
make
}
