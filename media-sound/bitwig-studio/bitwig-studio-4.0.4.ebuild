# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Based on: https://github.com/dstien/dstien-portage/blob/master/media-sound/bitwig-studio/bitwig-studio-1.1.8.ebuild

EAPI=6
inherit eutils xdg-utils gnome2-utils unpacker

DESCRIPTION="Music production and performance system"
HOMEPAGE="http://bitwig.com/"
SRC_URI="https://downloads.bitwig.com/stable/${PV}/${P}.deb"
LICENSE="Bitwig"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

IUSE="+jack cpu_flags_x86_sse4_1"
REQUIRED_USE="cpu_flags_x86_sse4_1"

DEPEND=""
RDEPEND="${DEPEND}
		dev-libs/expat
		dev-libs/libbsd
		gnome-extra/zenity
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libpng:0/16
		media-libs/mesa
		sys-libs/zlib
		media-video/ffmpeg
		media-sound/jack2
		virtual/jack
		virtual/opengl
		virtual/udev
		x11-libs/cairo
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXcursor
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libdrm
		x11-libs/libxcb
		x11-libs/libxkbfile
		x11-libs/pixman
		x11-libs/xcb-util-wm"

S=${WORKDIR}

src_prepare() {
	# Fix desktop file validation errors
        sed -i \
        -e 's/Icon=.*/Icon=bitwig-studio/' \
        -e 's/Categories=.*/Categories=AudioVideo;Audio;AudioVideoEditing/' \
        usr/share/applications/com.bitwig.BitwigStudio.desktop || die 'sed on desktop file failed'
	xdg_environment_reset
	eapply_user
}

src_install() {
	BITWIG_HOME="/opt/bitwig-studio"
	insinto ${BITWIG_HOME}
	doins -r opt/bitwig-studio/*

        fperms +x ${BITWIG_HOME}/bitwig-studio
	fperms +x ${BITWIG_HOME}/bin/BitwigAudioEngine-X64-AVX2
	fperms +x ${BITWIG_HOME}/bin/BitwigAudioEngine-X64-SSE41
	fperms +x ${BITWIG_HOME}/bin/BitwigPluginHost-X64-SSE41
	fperms +x ${BITWIG_HOME}/bin/BitwigStudio
	fperms +x ${BITWIG_HOME}/bin/BitwigVampHost
	fperms +x ${BITWIG_HOME}/bin/show-file-dialog-gtk3
	fperms +x ${BITWIG_HOME}/bin/show-splash-gtk

	rm -f "${ED}/${BITWIG_HOME}/bin/BitwigPluginHost-X86-SSE41"

	dosym ${BITWIG_HOME}/bitwig-studio /usr/bin/bitwig-studio

	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/com.bitwig.BitwigStudio.xml

	doicon -c apps -s 48 usr/share/icons/hicolor/48x48/apps/com.bitwig.BitwigStudio.png
	doicon -c apps -s scalable usr/share/icons/hicolor/scalable/apps/com.bitwig.BitwigStudio.svg
	doicon -c mimetypes -s scalable usr/share/icons/hicolor/scalable/mimetypes/com.bitwig.BitwigStudio.application-bitwig-*.svg

	domenu usr/share/applications/com.bitwig.BitwigStudio.desktop
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
