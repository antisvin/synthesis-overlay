# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils xdg-utils desktop

DESCRIPTION="Visual programming language for multimedia"
HOMEPAGE="http://msp.ucsd.edu/software.html"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pure-data/${PN}.git"
	KEYWORDS=""
else
	MY_PN="pd"
	MY_PV=${PV/_p/-}
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="http://msp.ucsd.edu/Software/${MY_P}.src.tar.gz
		https://puredata.info/portal_css/Plone%20Default/logo.png -> ${PN}.png"
	KEYWORDS="~amd64"
fi
LICENSE="BSD"
SLOT="0"

IUSE="+alsa jack nls oss portaudio portmidi"
REQUIRED_USE="portmidi? ( !oss )"

DEPEND="
	sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	nls? ( sys-devel/gettext )
	portaudio? ( media-libs/portaudio )
	portmidi? ( media-libs/portmidi )
"
RDEPEND="${DEPEND}
	dev-lang/tcl
	dev-lang/tk
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	mkdir -p "${S}/m4/generated"
	eautoreconf
}


src_configure() {
	# portmidi and portaudio, also disable usage of locally provided code
	econf \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable nls locales) \
		$(use_enable oss) \
		$(use_enable portmidi) \
		$(use_with !portmidi local-portmidi) \
		$(use_enable portaudio) \
		$(use_with !portaudio local-portaudio)
}

src_install() {
	default

	doicon -s 48 "${DISTDIR}"/${PN}.png
	make_desktop_entry pd "pure data" "${PN}" "AudioVideo;AudioVideoEditing"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
