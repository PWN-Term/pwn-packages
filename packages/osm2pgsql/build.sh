TERMUX_PKG_HOMEPAGE=https://osm2pgsql.org/
TERMUX_PKG_DESCRIPTION="osm2pgsql imports OpenStreetMap (OSM) data into a PostgreSQL/PostGIS database"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.5.0
TERMUX_PKG_SRCURL=https://github.com/openstreetmap/osm2pgsql/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d31be268dda21cf31418f68c78b8e0cbbd90cd8a283c4dfe0c134a7960936fce
TERMUX_PKG_DEPENDS="libexpat, proj, bzip2, zlib, boost, postgresql, lua54"
