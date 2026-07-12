#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

XDG_PORTALS=(
  xdg-utils
  xdg-user-dirs
  xdg-user-dirs-gtk
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-kde
)

PLASMA_SHELL=(
  kwin
  plasma-setup
  plasma-desktop
  plasma-keyboard
  plasma-workspace
  plasma-activities
  plasma-integration
  plasma-login-manager
  kde-settings-plasma
  kf6-qqc2-desktop-style
  plasma-lookandfeel-fedora
)

PLASMA_SESSION=(
  kscreen
  kunifiedpush
  kscreenlocker
  kwayland-integration
)

HARDWARE_INTEGRATION=(
  plasma-nm
  plasma-pa
  bluedevil
  powerdevil
  switcheroo-control
  plasma-thunderbolt
)

SECURITY_AUTH=(
  kwallet
  polkit-kde
  pam-kwallet
  pinentry-qt
  ksshaskpass
  signon-kwallet-extension
)

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

GHOSTTY=(
  ghostty
  ghostty-kio
  ghostty-neovim
  ghostty-terminfo
  ghostty-bat-syntax
  ghostty-zsh-completion
  ghostty-shell-integration
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

DOLPHIN_APPS=(
  ark
  dolphin
  dolphin-plugins
)

MISC_APPS=(
  code
  kcalc
  flatseal
  spectacle
  helium-drm
  input-remapper
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
  "${XDG_PORTALS[@]}"
  "${PLASMA_SHELL[@]}"
  "${PLASMA_SESSION[@]}"
  "${HARDWARE_INTEGRATION[@]}"
  "${SECURITY_AUTH[@]}"
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
  "${GHOSTTY[@]}"
  "${PLASMA_APPS[@]}"
  "${KDE_APPS[@]}"
  "${DOLPHIN_APPS[@]}"
  "${MISC_APPS[@]}"
  "${FCITX5[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"