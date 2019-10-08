# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7

inherit toolchain-funcs
 
DESCRIPTION="Faust (Functional Audio Stream) is a functional programming language specifically designed for real-time signal processing and synthesis."
HOMEPAGE="https://faust.grame.fr/"
SRC_URI="https://github.com/grame-cncm/${PN}/releases/download/${PV}/${P}.tar.gz"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"
 
DEPEND=">=net-libs/libmicrohttpd-0.9.66 >=sys-libs/llvm-6.0.1 >=dev-libs/openssl-1.1.1d >=sys-libs/ncurses-6.1_p20190609 >=media-libs/libsndfile-1.0.28-r4 >=dev-libs/libedit-20190324.3.1 >=net-misc/curl-7.66.0"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	tc-export CC CXX AR RANLIB
}

src_compile() {
	emake PREFIX="/usr"
}


src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	dodoc README.md

	if use doc; then
		dodoc documentation/faust-quick-reference.pdf
                dodoc documentation/faust-manual/faustManual.pdf
                dodoc documentation/*.pdf
	fi

	if use examples; then
		dodoc -r examples
	fi
}
