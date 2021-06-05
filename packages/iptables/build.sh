TERMUX_PKG_HOMEPAGE=https://gitlab.com/pwn-hunter/packages/iptables
TERMUX_PKG_DESCRIPTION="iptables is a user-space utility program that allows a system administrator to configure the IP packet filter rules of the Linux kernel firewall, implemented as different Netfilter modules."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.8.7
TERMUX_PKG_REVISION=6
TERMUX_PKG_SRCURL=https://gitlab.com/pwn-hunter/packages/iptables/-/archive/pwn/iptables-pwn.tar.gz
TERMUX_PKG_SHA256=426c0ffa95a85558ec35b81e5658c0a187a96282acb1bf9922be194d4935eb29
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	make install
}

