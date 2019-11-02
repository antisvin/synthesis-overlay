# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == *9999 ]]; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/grame-cncm/faust.git"
	GIT_ECLASS="git-r3"
	# In order of stability:
	# 9999-r0: master
	# 9999-r1: master-dev
	case "${PVR}" in
		9999) EGIT_BRANCH=master ;;
		9999-r1) EGIT_BRANCH=master-dev ;;
	esac
else
	GIT_ECLASS=""
	SRC_URI="https://github.com/grame-cncm/${PN}/archive/${PV}.tar.gz"
fi

inherit toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="Faust is a functional programming language for audio processing and synthesis."
HOMEPAGE="https://faust.grame.fr/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"
DEPEND=">=net-libs/libmicrohttpd-0.9.66 >=sys-devel/llvm-6.0.1:* >=dev-libs/openssl-1.1.1d >=sys-libs/ncurses-6.1_p20190609 >=media-libs/libsndfile-1.0.28-r4 >=dev-libs/libedit-20190324.3.1 >=net-misc/curl-7.66.0"
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
