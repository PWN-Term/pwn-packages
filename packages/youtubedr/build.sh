TERMUX_PKG_HOMEPAGE=https://github.com/kkdai/youtube
TERMUX_PKG_DESCRIPTION="Download youtube video in Golang"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
TERMUX_PKG_VERSION=2.7.6
TERMUX_PKG_SRCURL=https://github.com/kkdai/youtube/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=455a33cdd07698ee8a0227d029a10238a15a747007d09647cc65d45be29d82b2
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	termux_setup_golang

	cd "$TERMUX_PKG_SRCDIR"
	export GOPATH="${TERMUX_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/kkdai/"
	cp -a "${TERMUX_PKG_SRCDIR}" "${GOPATH}/src/github.com/kkdai/youtube"
	cd "${GOPATH}/src/github.com/kkdai/youtube/"
	go get -d -v
	cd cmd/youtubedr
	go build .
}

termux_step_make_install() {
	install -Dm700 -t "$TERMUX_PREFIX"/bin "$GOPATH"/src/github.com/kkdai/youtube/cmd/youtubedr/youtubedr
}
