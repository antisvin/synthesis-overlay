# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs
DESCRIPTION="an open source C++ toolkit for creative coding"
HOMEPAGE="https://openframeworks.cc"
SRC_URI="https://github.com/openframeworks/openFrameworks/archive/${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-libs/freeimage
	>=media-libs/glew-2.1
	media-sound/jack2
	media-libs/gstreamer
	media-libs/openal
	media-libs/freeglut
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-ugly
	media-plugins/gst-plugins-libav
	media-libs/opencv
	x11-libs/libXcursor
	media-libs/assimp
	dev-libs/boost
	media-libs/glfw
	dev-libs/uriparser
	net-misc/curl
	dev-libs/pugixml
	media-libs/rtaudio
	dev-libs/poco
	media-sound/mpg123
	media-libs/glm
	dev-cpp/nlohmann_json
	dev-libs/kissfft
	dev-libs/tess2
	dev-libs/utfcpp"
#media-sound/apulse
RDEPEND="${DEPEND}"
BDEPEND=""
S="${WORKDIR}/openFrameworks-${PV}"
PATCHES=(
        "${FILESDIR}/${P}-jack.patch"
)


src_compile() {
	cd "libs/openFrameworksCompiled/project"
	emake USE_FMOD=0
}
