TERMUX_PKG_HOMEPAGE=https://jfrog.com/getcli
TERMUX_PKG_DESCRIPTION="A CLI for JFrog products."
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.1.1
TERMUX_PKG_SRCURL=https://github.com/jfrog/jfrog-cli/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8e5378ad01471a3a030d9f6b2bc01468465b5e0e25009dab2d401cb5d2c4b36c
TERMUX_PKG_DEPENDS="libc++"

termux_step_make() {
	termux_setup_golang
	export GOPATH=$TERMUX_PKG_BUILDDIR

	cd $TERMUX_PKG_SRCDIR
	go build \
		-o "$TERMUX_PREFIX/bin/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$TERMUX_PKG_BUILDDIR/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

termux_step_make_install() {
	mkdir -p $TERMUX_PREFIX/share/bash-completion/completions
	export JFROG_CLI_HOME_DIR=$TERMUX_PKG_BUILDDIR/.jfrog
	$TERMUX_PKG_BUILDDIR/jfrog completion bash
	cp $TERMUX_PKG_BUILDDIR/.jfrog/jfrog_bash_completion $TERMUX_PREFIX/share/bash-completion/completions/jfrog

}
