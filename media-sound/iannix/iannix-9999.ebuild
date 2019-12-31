# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-r3

DESCRIPTION="Graphical score editor based on the previous UPIC developed by Iannis Xenakis"
HOMEPAGE="http://www.iannix.org/"
EGIT_REPO_URI="https://github.com/buzzinglight/IanniX.git"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples"

DEPEND="${RDEPEND}"
RDEPEND="dev-qt/qtcore:5
        dev-qt/qtgui:5
        dev-qt/qtsql:5
        dev-qt/qttest:5
        dev-qt/qtopengl:5
        dev-qt/qtsvg:5
        media-libs/freetype
        x11-libs/libSM
        x11-libs/libXrender
        media-libs/mesa
        media-libs/alsa-lib
        x11-libs/gdk-pixbuf"

DOCS=( Readme.md )

src_unpack() {
        git-r3_src_unpack
}

src_install() {
        qt4-r2_src_install

        cd "${S}/Patches/Ableton Live/"
        mv 'Icon'$'\r' Icon
        cd "${S}"

        insinto /usr/share/${PN}
        doins -r Patches
        doins -r Tools
        # It doesn't work anyway:
#       make_wrapper Iannix "/usr/bin/iannix" "/usr/share/${PN}" "/usr/share/${PN},/usr/share/${PN}/pixmaps"

        if use examples; then
                insinto /usr/share/${PN}
                doins -r Examples
        fi
}

pkg_postinst() {
        einfo "The installation script is a calimity,"
        einfo ""
        einfo "see https://github.com/buzzinglight/IanniX/issues"
        einfo ""
        einfo "for current issues."
        einfo ""

        if use examples; then
                einfo "The examples have been installed to /usr/share/${PN}/examples"
        fi
        einfo "The documentation is available by clicking on the ? button in IanniX"
}
