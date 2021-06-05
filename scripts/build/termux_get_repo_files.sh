termux_get_repo_files() {
	# Not needed for on-device builds.
	[ "$TERMUX_ON_DEVICE_BUILD" = "true" ] && return

	# Ensure folders present (but not $TERMUX_PKG_SRCDIR, it will be created in build)
	mkdir -p "$TERMUX_COMMON_CACHEDIR" \
		 "$TERMUX_COMMON_CACHEDIR-$TERMUX_ARCH" \
		 "$TERMUX_COMMON_CACHEDIR-all" \
		 "$TERMUX_DEBDIR" \
		 "$TERMUX_PKG_BUILDDIR" \
		 "$TERMUX_PKG_PACKAGEDIR" \
		 "$TERMUX_PKG_TMPDIR" \
		 "$TERMUX_PKG_CACHEDIR" \
		 "$TERMUX_PKG_MASSAGEDIR" \
		 $TERMUX_PREFIX/{bin,etc,lib,libexec,share,tmp,include}

	if [ "$TERMUX_INSTALL_DEPS" = true ]; then
		if [ "$TERMUX_NO_CLEAN" = false ]; then
			# Remove all previously extracted/built files from $TERMUX_PREFIX:
			rm -rf $TERMUX_PREFIX
			rm -f $TERMUX_BUILT_PACKAGES_DIRECTORY/*
		fi

		for idx in $(seq ${#TERMUX_REPO_URL[@]}); do
			local TERMUX_REPO_NAME=$(echo ${TERMUX_REPO_URL[$idx-1]} | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
			local RELEASE_FILE=${TERMUX_COMMON_CACHEDIR}/${TERMUX_REPO_NAME}-${TERMUX_REPO_DISTRIBUTION[$idx-1]}-Release

			local download_attempts=6
			while ((download_attempts > 0)); do
				if termux_download "${TERMUX_REPO_URL[$idx-1]}/dists/${TERMUX_REPO_DISTRIBUTION[$idx-1]}/Release" \
					"$RELEASE_FILE" SKIP_CHECKSUM && \
					termux_download "${TERMUX_REPO_URL[$idx-1]}/dists/${TERMUX_REPO_DISTRIBUTION[$idx-1]}/Release.gpg" \
					"${RELEASE_FILE}.gpg" SKIP_CHECKSUM; then
					break
				fi

				download_attempts=$((download_attempts - 1))
				if ((download_attempts < 1)); then
					termux_error_exit "Failed to download package repository metadata. Try to build without -i/-I option."
				fi

				echo "Retrying download in 30 seconds (${download_attempts} attempts left)..." >&2
				sleep 30
			done

			gpg --verify "${RELEASE_FILE}.gpg" "$RELEASE_FILE"

			for arch in all $TERMUX_ARCH; do
				local PACKAGES_HASH=$(./scripts/get_hash_from_file.py ${RELEASE_FILE} $arch ${TERMUX_REPO_COMPONENT[$idx-1]})
				# If packages_hash = "" then the repo probably doesn't contain debs for $arch
				if [ -n "$PACKAGES_HASH" ]; then
					termux_download "${TERMUX_REPO_URL[$idx-1]}/dists/${TERMUX_REPO_DISTRIBUTION[$idx-1]}/${TERMUX_REPO_COMPONENT[$idx-1]}/binary-$arch/Packages" \
							"${TERMUX_COMMON_CACHEDIR}-$arch/${TERMUX_REPO_NAME}-${TERMUX_REPO_DISTRIBUTION[$idx-1]}-${TERMUX_REPO_COMPONENT[$idx-1]}-Packages" \
							$PACKAGES_HASH
				fi
			done
		done
	fi
}
