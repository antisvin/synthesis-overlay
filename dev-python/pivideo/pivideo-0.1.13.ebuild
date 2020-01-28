# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_6 python3_7 )

inherit distutils-r1

DESCRIPTION="PiVideo Control Software ."
HOMEPAGE="https://pypi.org/project/PiVideo/ https://lintestsystems.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/future dev-python/smbus dev-python/pyserial"
