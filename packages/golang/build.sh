TERMUX_PKG_HOMEPAGE=https://golang.org/
TERMUX_PKG_DESCRIPTION="Go programming language compiler"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=1.16.3
# Use the ~ deb versioning construct in the future:
TERMUX_PKG_VERSION=2:${_MAJOR_VERSION}
TERMUX_PKG_SRCURL=https://storage.googleapis.com/golang/go${_MAJOR_VERSION}.src.tar.gz
TERMUX_PKG_SHA256=b298d29de9236ca47a023e382313bcc2d2eed31dfa706b60a04103ce83a71a25
TERMUX_PKG_DEPENDS="clang"
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_make_install() {
	termux_setup_golang

	TERMUX_GOLANG_DIRNAME=${GOOS}_$GOARCH
	TERMUX_GODIR=$TERMUX_PREFIX/lib/go

	cd $TERMUX_PKG_SRCDIR/src
	# Unset PKG_CONFIG to avoid the path being hardcoded into src/cmd/cgo/zdefaultcc.go,
	# see https://github.com/termux/termux-packages/issues/3505.
	env CC_FOR_TARGET=$CC \
	    CXX_FOR_TARGET=$CXX \
	    CC=gcc \
	    GO_LDFLAGS="-extldflags=-pie" \
	    GOROOT_BOOTSTRAP=$GOROOT \
	    GOROOT_FINAL=$TERMUX_GODIR \
	    PKG_CONFIG= \
	    ./make.bash

	cd ..
	rm -Rf $TERMUX_GODIR
	mkdir -p $TERMUX_GODIR/{bin,src,doc,lib,pkg/tool/$TERMUX_GOLANG_DIRNAME,pkg/include,pkg/${TERMUX_GOLANG_DIRNAME}}
	cp bin/$TERMUX_GOLANG_DIRNAME/{go,gofmt} $TERMUX_GODIR/bin/
	ln -sfr $TERMUX_GODIR/bin/go $TERMUX_PREFIX/bin/go
	ln -sfr $TERMUX_GODIR/bin/gofmt $TERMUX_PREFIX/bin/gofmt
	cp VERSION $TERMUX_GODIR/
	cp pkg/tool/$TERMUX_GOLANG_DIRNAME/* $TERMUX_GODIR/pkg/tool/$TERMUX_GOLANG_DIRNAME/
	cp -Rf src/* $TERMUX_GODIR/src/
	cp -Rf doc/* $TERMUX_GODIR/doc/
	cp pkg/include/* $TERMUX_GODIR/pkg/include/
	cp -Rf lib/* $TERMUX_GODIR/lib
	cp -Rf pkg/${TERMUX_GOLANG_DIRNAME}/* $TERMUX_GODIR/pkg/${TERMUX_GOLANG_DIRNAME}/
	cp -Rf misc/ $TERMUX_GODIR/
}

termux_step_post_massage() {
	find . -path '*/testdata*' -delete
}
