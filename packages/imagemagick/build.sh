TERMUX_PKG_HOMEPAGE=https://www.imagemagick.org/
TERMUX_PKG_DESCRIPTION="Suite to create, edit, compose, or convert images in a variety of formats"
TERMUX_PKG_LICENSE="ImageMagick"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=7.0.11.11
TERMUX_PKG_SRCURL=https://github.com/ImageMagick/ImageMagick/archive/$(echo $TERMUX_PKG_VERSION | sed 's/\(.*\)\./\1-/').tar.gz
TERMUX_PKG_SHA256=98ae45b0f904a733bd126132395864a913a57304e77994a5c83414c31feda549
TERMUX_PKG_DEPENDS="fftw, fontconfig, freetype, fribidi, glib, harfbuzz, libandroid-support, libbz2, libcairo, libffi, libgraphite, libjpeg-turbo, liblzma, libpixman, libpng, librsvg, libtiff, libuuid, libwebp, libx11, libxau, libxcb, libxdmcp, libxext, libxml2, littlecms, openjpeg, pango, pcre, zlib"
TERMUX_PKG_BREAKS="imagemagick-dev, imagemagick-x"
TERMUX_PKG_REPLACES="imagemagick-dev, imagemagick-x"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-x
--without-gvc
--with-magick-plus-plus=no
--with-bzlib=yes
--with-xml=yes
--with-rsvg=yes
--with-lzma
--disable-openmp
ac_cv_func_ftime=no
"

TERMUX_PKG_RM_AFTER_INSTALL="
share/ImageMagick-7/francais.xml
"

termux_step_pre_configure() {
	if [ $TERMUX_ARCH = "i686" ]; then
		#Avoid "libMagickCore-7.Q16HDRI.so: error: undefined reference to '__atomic_load'"
		LDFLAGS+=" -latomic"
	fi
}
