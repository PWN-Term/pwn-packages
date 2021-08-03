termux_setup_protobuf() {
	local _PROTOBUF_VERSION=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \${TERMUX_PKG_VERSION:2}")
	local _PROTOBUF_ZIP=protoc-$_PROTOBUF_VERSION-linux-x86_64.zip
	local _PROTOBUF_FOLDER

	if [ "${TERMUX_PACKAGES_OFFLINE-false}" = "true" ]; then
		_PROTOBUF_FOLDER=${TERMUX_SCRIPTDIR}/build-tools/protobuf-${_PROTOBUF_VERSION}
	else
		_PROTOBUF_FOLDER=${TERMUX_COMMON_CACHEDIR}/protobuf-${_PROTOBUF_VERSION}
	fi

	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$_PROTOBUF_FOLDER" ]; then
			termux_download \
				https://github.com/protocolbuffers/protobuf/releases/download/v$_PROTOBUF_VERSION/$_PROTOBUF_ZIP \
				$TERMUX_PKG_TMPDIR/$_PROTOBUF_ZIP \
				d4246a5136cf9cd1abc851c521a1ad6b8884df4feded8b9cbd5e2a2226d4b357

			rm -Rf "$TERMUX_PKG_TMPDIR/protoc-$_PROTOBUF_VERSION-linux-x86_64"
			unzip $TERMUX_PKG_TMPDIR/$_PROTOBUF_ZIP -d $TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION
			mv "$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION" \
				$_PROTOBUF_FOLDER
		fi

		export PATH=$_PROTOBUF_FOLDER/bin/:$PATH
	fi
}
