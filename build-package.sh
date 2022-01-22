#!/bin/bash
# shellcheck disable=SC1117

set -e -o pipefail -u

SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct 2>/dev/null || date "+%s")
export SOURCE_DATE_EPOCH

: "${TMPDIR:=/tmp}"
export TMPDIR

if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	if [ "$(id -u)" = "0" ]; then
		echo "On-device execution of this script as root is disabled."
		exit 1
	fi

	# This variable tells all parts of build system that build
	# is performed on device.
	export TERMUX_ON_DEVICE_BUILD=true
else
	export TERMUX_ON_DEVICE_BUILD=false
fi

cd "$(realpath "$(dirname "$0")")"
TERMUX_SCRIPTDIR=$(pwd)
export TERMUX_SCRIPTDIR

# Automatically enable offline set of sources and build tools.
# Offline termux-packages bundle can be created by executing
# script ./scripts/setup-offline-bundle.sh.
if [ -f "${TERMUX_SCRIPTDIR}/build-tools/.installed" ]; then
	export TERMUX_PACKAGES_OFFLINE=true
fi

# Lock file to prevent parallel running in the same environment.
TERMUX_BUILD_LOCK_FILE="${TMPDIR}/.termux-build.lck"
if [ ! -e "$TERMUX_BUILD_LOCK_FILE" ]; then
	touch "$TERMUX_BUILD_LOCK_FILE"
fi

# Special variable for internal use. It forces script to ignore
# lock file.
: "${TERMUX_BUILD_IGNORE_LOCK:=false}"

# Utility function to log an error message and exit with an error code.
# shellcheck source=scripts/build/termux_error_exit.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_error_exit.sh"

# Utility function to download a resource with an expected checksum.
# shellcheck source=scripts/build/termux_download.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_download.sh"

# Utility function for setting up GHC toolchain.
# shellcheck source=scripts/build/setup/termux_setup_ghc.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_ghc.sh"

# Utility function for setting up GN toolchain.
# shellcheck source=scripts/build/setup/termux_setup_gn.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_gn.sh"

# Utility function for golang-using packages to setup a go toolchain.
# shellcheck source=scripts/build/setup/termux_setup_golang.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_golang.sh"

# Utility function for rust-using packages to setup a rust toolchain.
# shellcheck source=scripts/build/setup/termux_setup_rust.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_rust.sh"

# Utility function to setup a current ninja build system.
# shellcheck source=scripts/build/setup/termux_setup_ninja.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_ninja.sh"

# Utility function to setup a current meson build system.
# shellcheck source=scripts/build/setup/termux_setup_meson.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_meson.sh"

# Utility function to setup a current cmake build system
# shellcheck source=scripts/build/setup/termux_setup_cmake.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_cmake.sh"

# Utility function to setup protobuf:
# shellcheck source=scripts/build/setup/termux_setup_protobuf.sh
source "$TERMUX_SCRIPTDIR/scripts/build/setup/termux_setup_protobuf.sh"

# Setup variables used by the build. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_setup_variables.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_setup_variables.sh"

# Save away and restore build setups which may change between builds.
# shellcheck source=scripts/build/termux_step_handle_buildarch.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_handle_buildarch.sh"

# Function to get TERMUX_PKG_VERSION from build.sh
# shellcheck source=scripts/build/termux_extract_dep_info.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_extract_dep_info.sh"

# Function that downloads a .deb (using the termux_download function)
# shellcheck source=scripts/build/termux_download_deb_pac.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_download_deb_pac.sh"

# Script to download InRelease, verify it's signature and then download Packages.xz by hash
# shellcheck source=scripts/build/termux_get_repo_files.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_get_repo_files.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_get_dependencies.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_get_dependencies.sh"

# Handle config scripts that needs to be run during build. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_override_config_scripts.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_override_config_scripts.sh"

# Remove old src and build folders and create new ones
# shellcheck source=scripts/build/termux_step_setup_build_folders.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_setup_build_folders.sh"

# Source the package build script and start building. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_start_build.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_start_build.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_create_timestamp_file.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_create_timestamp_file.sh"

# Run just after sourcing $TERMUX_PKG_BUILDER_SCRIPT. Can be overridden by packages.
# shellcheck source=scripts/build/get_source/termux_step_get_source.sh
source "$TERMUX_SCRIPTDIR/scripts/build/get_source/termux_step_get_source.sh"

# Run from termux_step_get_source if TERMUX_PKG_SRCURL ends with .git.
# shellcheck source=scripts/build/get_source/termux_step_get_source.sh
source "$TERMUX_SCRIPTDIR/scripts/build/get_source/termux_git_clone_src.sh"

# Run from termux_step_get_source if TERMUX_PKG_SRCURL does not ends with .git.
# shellcheck source=scripts/build/get_source/termux_download_src_archive.sh
source "$TERMUX_SCRIPTDIR/scripts/build/get_source/termux_download_src_archive.sh"

# Run from termux_step_get_source after termux_download_src_archive.
# shellcheck source=scripts/build/get_source/termux_unpack_src_archive.sh
source "$TERMUX_SCRIPTDIR/scripts/build/get_source/termux_unpack_src_archive.sh"

# Hook for packages to act just after the package sources have been obtained.
# Invoked from $TERMUX_PKG_SRCDIR.
termux_step_post_get_source() {
	return
}

# Optional host build. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_handle_hostbuild.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_handle_hostbuild.sh"

# Perform a host build. Will be called in $TERMUX_PKG_HOSTBUILD_DIR.
# After termux_step_post_get_source() and before termux_step_patch_package()
# shellcheck source=scripts/build/termux_step_host_build.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_host_build.sh"

# Setup a standalone Android NDK toolchain. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_setup_toolchain.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_setup_toolchain.sh"

# Apply all *.patch files for the package. Not to be overridden by packages.
# shellcheck source=scripts/build/termux_step_patch_package.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_patch_package.sh"

# Replace autotools build-aux/config.{sub,guess} with ours to add android targets.
# shellcheck source=scripts/build/termux_step_replace_guess_scripts.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_replace_guess_scripts.sh"

# For package scripts to override. Called in $TERMUX_PKG_BUILDDIR.
termux_step_pre_configure() {
	return
}

# Setup configure args and run $TERMUX_PKG_SRCDIR/configure. This function is called from termux_step_configure
# shellcheck source=scripts/build/configure/termux_step_configure_autotools.sh
source "$TERMUX_SCRIPTDIR/scripts/build/configure/termux_step_configure_autotools.sh"

# Setup configure args and run cmake. This function is called from termux_step_configure
# shellcheck source=scripts/build/configure/termux_step_configure_cmake.sh
source "$TERMUX_SCRIPTDIR/scripts/build/configure/termux_step_configure_cmake.sh"

# Setup configure args and run meson. This function is called from termux_step_configure
# shellcheck source=scripts/build/configure/termux_step_configure_meson.sh
source "$TERMUX_SCRIPTDIR/scripts/build/configure/termux_step_configure_meson.sh"

# Configure the package
# shellcheck source=scripts/build/configure/termux_step_configure.sh
source "$TERMUX_SCRIPTDIR/scripts/build/configure/termux_step_configure.sh"

# Hook for packages after configure step
termux_step_post_configure() {
	return
}

# Make package, either with ninja or make
# shellcheck source=scripts/build/termux_step_make.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_make.sh"

# Make install, either with ninja, make of cargo
# shellcheck source=scripts/build/termux_step_make_install.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_make_install.sh"

# Hook function for package scripts to override.
termux_step_post_make_install() {
	return
}

# Add service scripts from array TERMUX_PKG_SERVICE_SCRIPT, if it is set
# shellcheck source=scripts/build/termux_step_install_service_scripts.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_install_service_scripts.sh"

# Link/copy the LICENSE for the package to $TERMUX_PREFIX/share/$TERMUX_PKG_NAME/
# shellcheck source=scripts/build/termux_step_install_license.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_install_license.sh"

# Function to cp (through tar) installed files to massage dir
# shellcheck source=scripts/build/termux_step_extract_into_massagedir.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_extract_into_massagedir.sh"

# Hook function to create {pre,post}install, {pre,post}rm-scripts for subpkgs
termux_step_create_subpkg_debscripts() {
	return
}

# Create all subpackages. Run from termux_step_massage
# shellcheck source=scripts/build/termux_create_debian_subpackages.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_create_debian_subpackages.sh"

# Create all subpackages. Run from termux_step_massage
# shellcheck source=scripts/build/termux_create_pacman_subpackages.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_create_pacman_subpackages.sh"

# Function to run various cleanup/fixes
# shellcheck source=scripts/build/termux_step_massage.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_massage.sh"

# Hook for packages after massage step
termux_step_post_massage() {
	return
}

# Hook function to create {pre,post}install, {pre,post}rm-scripts and similar
termux_step_create_debscripts() {
	return
}

# Convert Debian maintainer scripts into pacman-compatible installation hooks.
# This is used only when creating pacman packages.
# shellcheck source=scripts/build/termux_step_create_pacman_install_hook.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_create_pacman_install_hook.sh"

# Create the build deb file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/termux_step_create_debian_package.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_create_debian_package.sh"

# Create the build .pkg.tar.xz file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/termux_step_create_pacman_package.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_create_pacman_package.sh"

# Finish the build. Not to be overridden by package scripts.
# shellcheck source=scripts/build/termux_step_finish_build.sh
source "$TERMUX_SCRIPTDIR/scripts/build/termux_step_finish_build.sh"

################################################################################

# shellcheck source=scripts/properties.sh
. "$TERMUX_SCRIPTDIR/scripts/properties.sh"

if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
	# For on device builds cross compiling is not supported.
	# Target architecture must be same as for environment used currently.
	TERMUX_ARCH=$(dpkg --print-architecture 2>/dev/null || pacman-conf | grep Architecture | sed 's/Architecture = //g')
	export TERMUX_ARCH
fi

# Special hook to prevent use of "sudo" inside package build scripts.
# build-package.sh shouldn't perform any privileged operations.
sudo() {
	termux_error_exit "Do not use 'sudo' inside build scripts. Build environment should be configured through ./scripts/setup-ubuntu.sh."
}

_show_usage() {
	echo "Usage: ./build-package.sh [options] PACKAGE_1 PACKAGE_2 ..."
	echo
	echo "Build a package by creating a .deb file in the debs/ folder."
	echo
	echo "Available options:"
	[ "$TERMUX_ON_DEVICE_BUILD" = "false" ] && echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -d Build with debug symbols."
	echo "  -D Build a disabled package in disabled-packages/."
	echo "  -f Force build even if package has already been built."
	[ "$TERMUX_ON_DEVICE_BUILD" = "false" ] && echo "  -i Download and extract dependencies instead of building them."
	echo "  -I Download and extract dependencies instead of building them, keep existing $TERMUX_BASE_DIR files."
	echo "  -q Quiet build."
	echo "  -s Skip dependency check."
	echo "  -o Specify directory where to put built packages. Default: output/."
	echo "  --format Specify package output format (debian, pacman)."
	exit 1
}

declare -a PACKAGE_LIST=()

if [ "$#" -lt 1 ]; then _show_usage; fi
while (($# >= 1)); do
	case "$1" in
		--) shift 1; break;;
		-h|--help) _show_usage;;
		--format)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					termux_error_exit "./build-package.sh: argument to '--format' should not be empty"
				fi

				case "$1" in
					debian|pacman) TERMUX_PACKAGE_FORMAT="$1";;
					*) termux_error_exit "./build-package.sh: only 'debian' and 'pacman' formats are supported";;
				esac
			else
				termux_error_exit "./build-package.sh: option '--format' requires an argument"
			fi
			;;
		-a)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					termux_error_exit "Argument to '-a' should not be empty."
				fi
				if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
					termux_error_exit "./build-package.sh: option '-a' is not available for on-device builds"
				else
					export TERMUX_ARCH="$1"
				fi
			else
				termux_error_exit "./build-package.sh: option '-a' requires an argument"
			fi
			;;
		-d) export TERMUX_DEBUG_BUILD=true;;
		-D) TERMUX_IS_DISABLED=true;;
		-f) TERMUX_FORCE_BUILD=true;;
		-i)
			if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
				termux_error_exit "./build-package.sh: option '-i' is not available for on-device builds"
			else
				export TERMUX_INSTALL_DEPS=true
			fi
			;;
		-I) export TERMUX_INSTALL_DEPS=true && export TERMUX_NO_CLEAN=true;;
		-q) export TERMUX_QUIET_BUILD=true;;
		-s) export TERMUX_SKIP_DEPCHECK=true;;
		-o)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					termux_error_exit "./build-package.sh: argument to '-o' should not be empty"
				fi
				TERMUX_OUTPUT_DIR=$(realpath -m "$1")
			else
				termux_error_exit "./build-package.sh: option '-o' requires an argument"
			fi
			;;
		-c) TERMUX_CONTINUE_BUILD=true;;
		-*) termux_error_exit "./build-package.sh: illegal option '$1'";;
		*) PACKAGE_LIST+=("$1");;
	esac
	shift 1
done
unset -f _show_usage

if [ "${TERMUX_INSTALL_DEPS-false}" = "true" ]; then
	# Setup PGP keys for verifying integrity of dependencies.
	# Keys are obtained from our keyring package.
	
	# Dont force to include termux gpg files
fi

for ((i=0; i<${#PACKAGE_LIST[@]}; i++)); do
	# Following commands must be executed under lock to prevent running
	# multiple instances of "./build-package.sh".
	#
	# To provide sane environment for each package, builds are done
	# in subshell.
	(
		if ! $TERMUX_BUILD_IGNORE_LOCK; then
			flock -n 5 || termux_error_exit "Another build is already running within same environment."
		fi

		# Handle 'all' arch:
		if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ] && [ -n "${TERMUX_ARCH+x}" ] && [ "${TERMUX_ARCH}" = 'all' ]; then
			for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
				env TERMUX_ARCH="$arch" TERMUX_BUILD_IGNORE_LOCK=true ./build-package.sh \
					${TERMUX_FORCE_BUILD+-f} ${TERMUX_INSTALL_DEPS+-i} ${TERMUX_IS_DISABLED+-D} \
					${TERMUX_DEBUG_BUILD+-d} ${TERMUX_OUTPUT_DIR+-o $TERMUX_OUTPUT_DIR} \
					--format ${TERMUX_PACKAGE_FORMAT:=debian} "${PACKAGE_LIST[i]}"
			done
			exit
		fi

		# Check the package to build:
		TERMUX_PKG_NAME=$(basename "${PACKAGE_LIST[i]}")
		if [[ ${PACKAGE_LIST[i]} == *"/"* ]]; then
			# Path to directory which may be outside this repo:
			if [ ! -d "${PACKAGE_LIST[i]}" ]; then termux_error_exit "'${PACKAGE_LIST[i]}' seems to be a path but is not a directory"; fi
			export TERMUX_PKG_BUILDER_DIR
			TERMUX_PKG_BUILDER_DIR=$(realpath "${PACKAGE_LIST[i]}")
		else
			# Package name:
			if [ -n "${TERMUX_IS_DISABLED=""}" ]; then
				export TERMUX_PKG_BUILDER_DIR=$TERMUX_SCRIPTDIR/disabled-packages/$TERMUX_PKG_NAME
			else
				export TERMUX_PKG_BUILDER_DIR=$TERMUX_SCRIPTDIR/packages/$TERMUX_PKG_NAME
			fi
		fi
		TERMUX_PKG_BUILDER_SCRIPT=$TERMUX_PKG_BUILDER_DIR/build.sh
		if test ! -f "$TERMUX_PKG_BUILDER_SCRIPT"; then
			termux_error_exit "No build.sh script at package dir $TERMUX_PKG_BUILDER_DIR!"
		fi

		termux_step_setup_variables
		termux_step_handle_buildarch

		if [ "$TERMUX_CONTINUE_BUILD" == "false" ]; then
			termux_step_setup_build_folders
		fi

		termux_step_start_build

		if [ "$TERMUX_CONTINUE_BUILD" == "false" ]; then
			termux_step_get_dependencies
			termux_step_override_config_scripts
		fi

		termux_step_create_timestamp_file

		if [ "$TERMUX_CONTINUE_BUILD" == "false" ]; then
			cd "$TERMUX_PKG_CACHEDIR"
			termux_step_get_source
			cd "$TERMUX_PKG_SRCDIR"
			termux_step_post_get_source
			termux_step_handle_hostbuild
		fi

		termux_step_setup_toolchain

		if [ "$TERMUX_CONTINUE_BUILD" == "false" ]; then
			termux_step_patch_package
			termux_step_replace_guess_scripts
			cd "$TERMUX_PKG_SRCDIR"
			termux_step_pre_configure
		fi

		# Even on continued build we might need to setup paths
		# to tools so need to run part of configure step
		cd "$TERMUX_PKG_BUILDDIR"
		termux_step_configure

		if [ "$TERMUX_CONTINUE_BUILD" == "false" ]; then
			cd "$TERMUX_PKG_BUILDDIR"
			termux_step_post_configure
		fi
		cd "$TERMUX_PKG_BUILDDIR"
		termux_step_make
		cd "$TERMUX_PKG_BUILDDIR"
		termux_step_make_install
		cd "$TERMUX_PKG_BUILDDIR"
		termux_step_post_make_install
		termux_step_install_service_scripts
		termux_step_install_license
		cd "$TERMUX_PKG_MASSAGEDIR"
		termux_step_extract_into_massagedir
		termux_step_massage
		cd "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
		termux_step_post_massage
		cd "$TERMUX_PKG_MASSAGEDIR"
		if [ "$TERMUX_PACKAGE_FORMAT" = "debian" ]; then
			termux_step_create_debian_package
		elif [ "$TERMUX_PACKAGE_FORMAT" = "pacman" ]; then
			termux_step_create_pacman_package
		else
			termux_error_exit "Unknown packaging format '$TERMUX_PACKAGE_FORMAT'."
		fi
		termux_step_finish_build
	) 5< "$TERMUX_BUILD_LOCK_FILE"
done
