# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SCM="git-r3"
EGIT_REPO_URI="https://github.com/tasanakorn/rpi-fbcp.git"
GIT_ECLASS="git-r3"
EGIT_BRANCH=master

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="Program to copy primary framebuffer to secondary framebuffer"
HOMEPAGE="https://github.com/tasanakorn/rpi-fbcp"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""
DEPEND=">=media-libs/raspberrypi-userland-1.20190808"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin "${BUILD_DIR}/fbcp"
}