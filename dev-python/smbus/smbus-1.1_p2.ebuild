# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_6 python3_7 )

inherit distutils-r1

MY_PV=${PV/_p/.post}
MY_P=${PN}-${MY_PV}
DESCRIPTION="Python bindings for Linux SMBus access through i2c-dev"
HOMEPAGE="https://pypi.org/project/pysmbus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64"

S="${WORKDIR}/${MY_PV}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
