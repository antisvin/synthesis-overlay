# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Game and tools oriented refactored version of GLU tesselator."
HOMEPAGE="https://github.com/memononen/libtess2"
SRC_URI="https://github.com/memononen/${PN}/archive/v${PV}.tar.gz"
KEYWORDS="amd64 arm64"
LICENSE="SGI"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/glu
	media-libs/glew
"
DEPEND="${RDEPEND}
	dev-util/premake:4"

DOCS=( alg_outline.md README.md )

src_configure() {
	premake4 gmake --platform=$(usex amd64 "x64" "x32")
	# Fix ARCH variable - conflicts with Gentoo env var
	sed 's/$(ARCH) //g' -i Build/tess2.make || die
}

src_compile() {
	cd Build
	make config=release$(usex amd64 "64" "32") verbose=1 tess2
}

src_install() {
        dolib.a Build/libtess2.a
	doheader Include/tesselator.h
}
