TERMUX_PKG_HOMEPAGE=https://www.gaia-gis.it/fossil/spatialite-tools
TERMUX_PKG_DESCRIPTION="Collection of tools supporting SpatiaLite"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=5.0.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://www.gaia-gis.it/gaia-sins/spatialite-tools-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9604c205e87f037789bc52302c66ccd1371c3e98c74e8ec4e29b0752de35171c
TERMUX_PKG_DEPENDS="libgeos, libexpat, sqlite, proj, libspatialite"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-readosm --disable-minizip"