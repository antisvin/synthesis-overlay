# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit versionator autotools-utils
MY_P="${PN}-$(replace_version_separator "3" ".")"
DESCRIPTION="a simple video player that is synchronized to jack transport."
HOMEPAGE="http://${PN}.sf.net/"
SRC_URI="https://github.com/x42/xjadeo/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa imlib midi osc osd portmidi sdl tools xv"
REQUIRED_USE="alsa? ( midi )
        portmidi? ( midi )"

RDEPEND="virtual/jack
        >=media-video/ffmpeg-1.0.0
        midi? (
                alsa? ( >=media-libs/alsa-lib-1.0.10 )
                portmidi? ( media-libs/portmidi )
        )
        imlib? ( >=media-libs/imlib2-1.3.0 )
        osc? ( media-libs/liblo )
        sdl? ( >=media-libs/libsdl-1.2.8 )"

DEPEND="${RDPEND}
        >=sys-libs/zlib-1.2.2
        virtual/pkgconfig"

#PATCHES=( "${FILESDIR}/${P}-no-libporttime.patch" )

AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

DOCS=( AUTHORS ChangeLog README NEWS )

S="${WORKDIR}/${MY_P}"

src_configure() {
        local myeconfargs=(
                $(use_enable imlib imlib2)
                $(use_enable midi alsamidi)
                $(use_enable portmidi)
                $(use_enable osc)
                $(use_enable osd ft)
                $(use_enable sdl)
                $(use_enable tools contrib)
                $(use_enable xv)
                --disable-timescale
        )

        autotools-utils_src_configure
}

src_install() {
        autotools-utils_src_install
        if use tools; then
                newdoc contrib/cli-remote/README README.cli-remote
                dobin contrib/cli-remote/jadeo-rcli
                insinto "/usr/share/${PN}"
                doins "contrib/${PN}-example.mp4"
        fi
}
