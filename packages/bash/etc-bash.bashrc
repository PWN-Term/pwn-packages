#################################################
# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.

# VER:1.2.2
# Modified by Martin Valba/@hilledkinged

#
# PWN-Stuff
#

mkdir -p /data/data/hilled.pwnterm/files/usr/home
export HOME=/data/data/hilled.pwnterm/files/usr/home

###
# Xwayland / xorg-server

# Predefine xdg runtime path for easier startups of xwayland servers
export XDG_RUNTIME_DIR=/data/data/hilled.pwnterm/files/usr/tmp

# End of Xwayland / xorg-server fixes
###

###
# Cargo temp fixes

# Cargo path related (Make bin and path it for further use)
CARGO=/data/data/hilled.pwnterm/files/usr/home/.cargo/bin
mkdir -p $CARGO
# cat eof config if not present
FILE=/data/data/hilled.pwnterm/files/usr/home/.cargo/config
if [[ -f "$FILE" ]]; then
    cat <<EOF > $FILE
[http]
cainfo = "/data/data/hilled.pwnterm/files/usr/etc/tls/cert.pem"
EOF
fi

# End of cargo fixes
###

shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
PS1='\[\e[0;32m\]\w\[\e[0m\] \[\e[0;97m\]\$\[\e[0m\] '

# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x/data/data/hilled.pwnterm/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/hilled.pwnterm/files/usr/libexec/termux/command-not-found "$1"
	}
fi

# Export pwn things
PREFIX=/data/data/hilled.pwnterm/files/usr
PBIN=/data/data/hilled.pwnterm/files/usr/bin
EPBIN=$PBIN/ruby2
PSBIN=/data/data/hilled.pwnterm/files/usr/sbin
export PATH=$PBIN:$PSBIN:$CARGO:$PATH

# Export default libs path for executables to load
PLIB=$PREFIX/lib
ALIB=/apex/com.android.runtime/lib64/bionic:/apex/com.android.runtime/lib64
SLIB=/system/lib64
VLIB=/vendor/lib64
export LD_LIBRARY_PATH=$PLIB:$ALIB:$SLIB:$VLIB


# Some useful stuff
alias home='cd ~'
alias root='cd /data/data/hilled.pwnterm/files/usr'
alias full-upgrade='apt update && apt full-upgrade'

alias ls='ls --color=auto $@'
alias sudo='su -c "$@"'

# Now start at home dir
home

# And cat the motd
cat /data/data/hilled.pwnterm/files/usr/etc/bash.motd