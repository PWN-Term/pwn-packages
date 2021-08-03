TERMUX_PKG_HOMEPAGE=https://groovy-lang.org/
TERMUX_PKG_DESCRIPTION="A powerful multi-faceted programming language for the JVM platform"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.0.8
TERMUX_PKG_SRCURL=https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=87cf2a61b77f6378ae1081cfda9d14bc651271b25ffac57fc936cd17662e3240
TERMUX_PKG_DEPENDS="openjdk-17"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $TERMUX_PREFIX/opt/groovy
	mkdir -p $TERMUX_PREFIX/opt/groovy
	cp -r ./* $TERMUX_PREFIX/opt/groovy/
	for i in $TERMUX_PREFIX/opt/groovy/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $TERMUX_PREFIX/bin/$(basename $i)
	done
}
