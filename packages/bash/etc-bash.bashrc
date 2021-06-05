#################################################
# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.

# VER:1.2.0
# Modified by Martin Valba/@hilledkinged

#
# PWN-Stuff
#

# Some chown's even if su wasnt used
export IDME=$(whoami)
chown -R $IDME:$IDME /data/data/hilled.pwnterm/cache
unset $IDME

# JDK8
#export PATH=$PATH:/data/data/hilled.pwnterm/files/usr/lib/jvm/java-8-openjdk-arm64/bin:/data/data/hilled.pwnterm/files/usr/lib/jvm/java-8-openjdk-arm64/db/bin:/data/data/hilled.pwnterm/files/usr/lib/jvm/java-8-openjdk-arm64/lib

mkdir -p /data/data/hilled.pwnterm/files/usr/home
HOME=/data/data/hilled.pwnterm/files/usr/home

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

# Some useful stuff
alias home='cd ~'
alias root='cd /data/data/hilled.pwnterm/files/usr'
alias full-upgrade='apt update && apt upgrade'

alias ls='ls --color=auto $@'
alias sudo='su -c "$@"'

alias install-wireless='full-upgrade && apt install airgeddon wifite'
alias force-reinstall='apt-get -o Dpkg::Options::="--force-overwrite" install --reinstall'

# Now start on home dir
home

# And now cat the motd
cat /data/data/hilled.pwnterm/files/usr/etc/bash.motd
