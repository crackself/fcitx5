# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-rime.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/fcitx/fcitx5-rime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"
IUSE=""

RDEPEND="app-i18n/fcitx5
	>=app-i18n/librime-1.0
	x11-libs/libnotify
	!app-i18n/fcitx-rime"

DEPEND="${RDEPEND}"

src_configure() {
        local mycmakeargs=(
                -DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
                -DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DBUILD_SHARED_LIBS=TRUE
		-DRIME_DATA_DIR=/etc/rime
        )
        cmake_src_configure
}

pkg_postinst() {
        xdg_pkg_postinst
}
