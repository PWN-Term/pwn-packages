TERMUX_PKG_HOMEPAGE=https://github.com/junegunn/fzf
TERMUX_PKG_DESCRIPTION="Command-line fuzzy finder"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.27.2
TERMUX_PKG_SRCURL=https://github.com/junegunn/fzf/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=7798a9e22fc363801131456dc21026ccb0f037aed026d17df60b1178b3f24111

# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
TERMUX_PKG_DEPENDS="bash, findutils"

termux_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if $TERMUX_ON_DEVICE_BUILD; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' is not safe for on-device builds."
	fi
}

termux_step_make() {
	termux_setup_golang

	export GOPATH=$TERMUX_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/junegunn
	mv $TERMUX_PKG_SRCDIR $GOPATH/src/github.com/junegunn/fzf
	TERMUX_PKG_SRCDIR=$GOPATH/src/github.com/junegunn/fzf

	cd $GOPATH/src/github.com/junegunn/fzf
	go get -d -v github.com/junegunn/fzf
	go build
}

termux_step_make_install() {
	cd $GOPATH/src/github.com/junegunn/fzf

	install -Dm700 fzf $TERMUX_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	install -Dm700 $TERMUX_PKG_SRCDIR/bin/fzf-tmux $TERMUX_PREFIX/bin/fzf-tmux

	# Install the fzf.1 man page:
	mkdir -p $TERMUX_PREFIX/share/man/man1/
	cp $TERMUX_PKG_SRCDIR/man/man1/fzf.1 $TERMUX_PREFIX/share/man/man1/

	# Install bash completion script:
	mkdir -p $TERMUX_PREFIX/share/bash-completion/completions/
	cp $TERMUX_PKG_SRCDIR/shell/completion.bash $TERMUX_PREFIX/share/bash-completion/completions/fzf

	# Install the rest of the shell scripts:
	mkdir -p $TERMUX_PREFIX/share/fzf
	cp $TERMUX_PKG_SRCDIR/shell/* $TERMUX_PREFIX/share/fzf/

	# Install the nvim plugin:
	mkdir -p $TERMUX_PREFIX/share/nvim/runtime/plugin
	cp $TERMUX_PKG_SRCDIR/plugin/fzf.vim $TERMUX_PREFIX/share/nvim/runtime/plugin/
}
