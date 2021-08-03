TERMUX_PKG_HOMEPAGE=https://docker.com
TERMUX_PKG_DESCRIPTION="Set of products that use OS-level virtualization to deliver software in packages called containers."
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
# remember to update DOCKER_GITCOMMIT inside termux_step_make()
# bellow when upgrading to a new version
TERMUX_PKG_VERSION=20.10.2
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=(https://github.com/PWN-Term/Docker/archive/refs/heads/${TERMUX_PKG_VERSION}.tar.gz)
TERMUX_PKG_SHA256=(532a64f154d4807983fd2de0bab5291c435760baf4349e3d7780e4265853af0c)
TERMUX_PKG_DEPENDS="containerd"
TERMUX_PKG_CONFFILES="etc/docker/daemon.json"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	# setup go build environment
	termux_setup_golang

    ### Build --init support
    echo -n "Building Tini daemon..."
	(
	set -e
	termux_setup_cmake
    cd tini
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX} ..
    make
    make install
    ln -s ${TERMUX_PREFIX}/bin/tini-static ${TERMUX_PREFIX}/bin/docker-init
	)

	# BUILD DOCKERD DAEMON
	echo " "
	echo -n "Building dockerd daemon..."
	(
	set -e
	cd moby

	# issue the build command
	export DOCKER_GITCOMMIT=8891c58a43
	export DOCKER_BUILDTAGS='exclude_graphdriver_btrfs exclude_graphdriver_devicemapper exclude_graphdriver_quota selinux exclude_graphdriver_aufs'
	# horrible, but effective way to apply patches on the fly while compiling
	while ! IFS='' files=$(AUTO_GOPATH=1 PREFIX='' hack/make.sh dynbinary 2>&1 1>/dev/null); do if ! xargs sed -i 's/\("runtime"\)/_ \1/' < <(echo $files | grep runtime | cut -d':' -f1 | cut -c38-); then echo $files; exit 1; fi; done
	)
	echo " "
	echo "[!]: MOBY Done!"

	# BUILD DOCKER-PROXY BINARY FROM LIBNETWORK
	echo -n "Building docker-proxy from libnetwork..."
	(
	set -e
	echo " "
    echo "[*]: Path fixes..."
	# fix path locations to build with go
	mkdir -p go/src/github.com/docker
	mv libnetwork go/src/github.com/docker
	mkdir libnetwork
	mv go libnetwork
	export GOPATH="${PWD}/libnetwork/go"
	cd "${GOPATH}/src/github.com/docker/libnetwork"

	# issue the build command
	echo " "
	echo "[*]: Building..."
	go build -o docker-proxy github.com/docker/libnetwork/cmd/proxy
	)
	echo " "
	echo "[!]: LIBN Done!"

	# BUILD DOCKER-CLI CLIENT
	echo " "
	echo -n "Building docker-cli client..."
	(
	set -e

	# fix path locations to build with go
	echo " "
	echo "[*]: Path fixes..."
	mkdir -p go/src/github.com/docker
	mv cli go/src/github.com/docker
	mkdir cli
	mv go cli
	export GOPATH="${PWD}/cli/go"
	cd "${GOPATH}/src/github.com/docker/cli"

	# issue the build command
	echo " "
	echo "[*]: Buidling..."
	export VERSION=v${TERMUX_PKG_VERSION}-ce
	export DISABLE_WARN_OUTSIDE_CONTAINER=1
	export LDFLAGS="-L ${TERMUX_PREFIX}/lib -r ${TERMUX_PREFIX}/lib"
	make -j ${TERMUX_MAKE_PROCESSES} dynbinary
	unset GOOS GOARCH CGO_LDFLAGS CC CXX CFLAGS CXXFLAGS LDFLAGS
	make -j ${TERMUX_MAKE_PROCESSES} manpages
	)
	echo " "
	echo "[!]: CLI Done!"
    echo " "
}

termux_step_make_install() {
    echo " "
    echo "[*]: Installing..."
    echo "[-]: dockerd"
	install -Dm 700 moby/bundles/dynbinary-daemon/dockerd ${TERMUX_PREFIX}/libexec/dockerd
	echo "[-]: docker-proxy"
	install -Dm 700 libnetwork/go/src/github.com/docker/libnetwork/docker-proxy ${TERMUX_PREFIX}/bin/docker-proxy
	echo "[-]: docker"
	install -Dm 700 cli/go/src/github.com/docker/cli/build/docker-android-* ${TERMUX_PREFIX}/bin/docker
	echo "[-]: man1"
	install -Dm 600 -t ${TERMUX_PREFIX}/share/man/man1 cli/go/src/github.com/docker/cli/man/man1/*
	echo "[-]: man5"
	install -Dm 600 -t ${TERMUX_PREFIX}/share/man/man5 cli/go/src/github.com/docker/cli/man/man5/*
	echo "[-]: man8"
	install -Dm 600 -t ${TERMUX_PREFIX}/share/man/man8 cli/go/src/github.com/docker/cli/man/man8/*
	echo "[-]: daemon.json"
	install -Dm 600 ${TERMUX_PKG_BUILDER_DIR}/daemon.json ${TERMUX_PREFIX}/etc/docker/daemon.json
	echo "[-]: dockerd (Additional)"
	sed -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
	       "${TERMUX_PKG_BUILDER_DIR}/dockerd.sh" > "${TERMUX_PREFIX}/bin/dockerd"
	chmod 700 "${TERMUX_PREFIX}/bin/dockerd"
    echo " "
	echo "[-]: Done installing..."
}

termux_step_create_debscripts() {
    echo " "
    echo "[!]: Creating debscript..."
	cat <<- EOF > postinst
		#!${TERMUX_PREFIX}/bin/sh

		echo 'NOTE: Docker requires the kernel to support'
		echo 'device cgroups, namespace, VETH, among others.'
		echo
		echo 'To check a full list of features needed, run the script:'
		echo 'https://github.com/moby/moby/blob/master/contrib/check-config.sh'
	EOF
}
