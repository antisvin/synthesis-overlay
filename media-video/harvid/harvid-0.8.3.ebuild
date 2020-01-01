# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs
DESCRIPTION="decodes still images from movie files and serves them via HTTP"
HOMEPAGE="http://x42.github.io/harvid/"
SRC_URI="https://github.com/x42/harvid/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa imlib midi osc osd portmidi sdl tools xv"
#REQUIRED_USE=""

RDEPEND="media-video/ffmpeg
         media-libs/libpng
         media-libs/libjpeg-turbo"

DEPEND="${RDEPEND} app-editors/vim"

DOCS=( ChangeLog README.md )


src_compile() {
        emake -j1 PREFIX=/usr
}

src_install() {
        emake PREFIX=/usr DESTDIR="${D}" install
}
