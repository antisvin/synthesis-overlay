# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A mixed-radix Fast Fourier Transform library"
HOMEPAGE="https://github.com/mborgerding/kissfft"
SRC_URI="https://github.com/mborgerding/${PN}/archive/v${PV}.tar.gz"
KEYWORDS="amd64 arm64"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
DOCS=( CHANGELOG README )

PATCHES=(
        "${FILESDIR}/${P}-makefile.patch"
)

src_compile() {
	emake
}

src_install() {
        dolib.a libkiss.a
	doheader kiss_fft.h
	doheader tools/kiss_fftr.h
}
