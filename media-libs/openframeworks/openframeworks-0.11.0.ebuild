# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == *9999 ]]; then
        SCM="git-r3"
        EGIT_REPO_URI="https://github.com/openframeworks/openFrameworks.git"
        GIT_ECLASS="git-r3"
        # In order of stability:
        # 9999-r0: stable
        # 9999-r1: master
        case "${PVR}" in
                9999-r0) EGIT_BRANCH=stable ;;
                9999-r1) EGIT_BRANCH=master ;;
        esac
else
        GIT_ECLASS=""
	SRC_URI="https://github.com/openframeworks/openFrameworks/archive/${PV}.tar.gz"
fi

inherit toolchain-funcs ${GIT_ECLASS}
DESCRIPTION="an open source C++ toolkit for creative coding"
HOMEPAGE="https://openframeworks.cc"
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
	media-libs/kissfft
	media-libs/libtess2
	dev-libs/utfcpp"
#media-sound/apulse
RDEPEND="${DEPEND}"
BDEPEND=""
S="${WORKDIR}/openFrameworks-${PVR}"
PATCHES=(
        "${FILESDIR}/${P}-jack.patch"
)

INCLUDEPATH=${TOOLCHAIN_INCLUDEPATH:/usr/include/utf8cpp}

src_compile() {
	cd "libs/openFrameworksCompiled/project"
	emake USE_FMOD=0
}

src_install() {
	dolib.a "libs/openFrameworksCompiled/lib/linux64/libopenFrameworks.a"
}
