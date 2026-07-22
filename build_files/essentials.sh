#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

KIO_PROTOCOLS=(
  kdnssd
  kio-fuse
  kio-admin
  kio-gdrive
)

NETWORK_VPN=(
  ldns
  plasma-firewall
  plasma-nm-openvpn
  plasma-nm-openconnect
  plasma-firewall-firewalld
)

GTK_THEMING=(
  kde-gtk-config
  breeze-gtk-gtk3
  breeze-gtk-gtk4
)

WINDOW_EFFECTS=(
  plasma-wayland-protocols
  kwin-effect-roundcorners
)

SEARCH_INDEXING=(
  plasma-milou
  kf6-baloo-file
  kde-inotify-survey
)

ACCESSIBILITY=(
  orca
  espeak-ng
  speech-dispatcher
)

THUMBNAILS_CODECS=(
  ffmpegthumbs
  qt6-qtimageformats
  kdegraphics-thumbnailers
)

KDE_ADDONS=(
  kdeplasma-addons
  kdenetwork-filesharing
  plasma-browser-integration
)

STORAGE_DISKS=(
  plasma-vault
  plasma-disks
)

PRINTING=(
  plasma-print-manager
)

LOCALIZATION_FONTS=(
  adwaita-fonts-all
  glibc-all-langpacks
)

KCM_MODULES=(
  flatpak-kcm
  kcm-plasmalogin
  kcm-plasma-keyboard
)

REMOTE_ACCESS=(
  krdc
  krfb
  krdp
)

SYSTEM_MISC=(
  nss-tools
  colord-kde
)

# GHOSTTY extras not already installed by mx-setup.sh
# (mx installs: ghostty, ghostty-zsh-completion, ghostty-shell-integration)
GHOSTTY_EXTRAS=(
  ghostty-kio
  ghostty-neovim
  ghostty-terminfo
  ghostty-bat-syntax
)

PLASMA_APPS=(
  plasma-discover
  plasma-discover-kns
  plasma-systemmonitor
  plasma-systemsettings
  plasma-discover-flatpak
  plasma-discover-notifier
)

KDE_APPS=(
  kinfocenter
  kde-connect
  kde-partitionmanager
)

MISC_APPS=(
  kcalc
  flatseal
  spectacle
  helium-drm
)

FCITX5=(
  fcitx5
  fcitx5-gtk
  fcitx5-qt6
  kcm-fcitx5
  fcitx5-mozc
  fcitx5-m17n
  fcitx5-rime
  fcitx5-hangul
  fcitx5-unikey
  fcitx5-chewing
  fcitx5-libthai
  fcitx5-configtool
  fcitx5-table-extra
  fcitx5-chinese-addons
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${KIO_PROTOCOLS[@]}"
  "${NETWORK_VPN[@]}"
  "${GTK_THEMING[@]}"
  "${WINDOW_EFFECTS[@]}"
  "${SEARCH_INDEXING[@]}"
  "${ACCESSIBILITY[@]}"
  "${THUMBNAILS_CODECS[@]}"
  "${KDE_ADDONS[@]}"
  "${STORAGE_DISKS[@]}"
  "${PRINTING[@]}"
  "${LOCALIZATION_FONTS[@]}"
  "${KCM_MODULES[@]}"
  "${REMOTE_ACCESS[@]}"
  "${SYSTEM_MISC[@]}"
  "${GHOSTTY_EXTRAS[@]}"
  "${PLASMA_APPS[@]}"
  "${KDE_APPS[@]}"
  "${MISC_APPS[@]}"
  "${FCITX5[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"