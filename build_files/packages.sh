#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

XDG=(
  xdg-utils
  xdg-user-dirs
  xdg-user-dirs-gtk
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-kde
)

PLASMA_BASE=(
  kwin
  plasma-nm
  plasma-pa
  plasma-setup
  plasma-desktop
  plasma-drkonqi
  plasma-keyboard
  plasma-workspace
  plasma-activities
  plasma-integration
  plasma-login-manager
  kf6-qqc2-desktop-style
  plasma-lookandfeel-fedora
)

KDE_BASE=(
  kscreen
  kunifiedpush
  kscreenlocker
  kde-settings-plasma
  kwayland-integration
)

PLASMA_BASE_MISC=(
  bluedevil
  powerdevil
  ffmpegthumbs
)

KDE_ADDONS=(
  kdeplasma-addons
  kdenetwork-filesharing
  kdegraphics-thumbnailers
)

PLASMA_ADDONS=(
  plasma-vault
  plasma-disks
  plasma-nm-openvpn
  plasma-nm-openconnect
)

SECURITY_MISC=(
  kwallet
  polkit-kde
  pam-kwallet
  pinentry-qt
  switcheroo-control
  signon-kwallet-extension
)

KDE_EXTRAS=(
  kio-admin
  kcm-plasmalogin
  kcm-plasma-keyboard
  kwin-effect-roundcorners
)

PLASMA_EXTRAS=(
  plasma-print-manager
)

MISC_EXTRAS=(
  ldns
  kdnssd
  nss-tools
  colord-kde
  flatpak-kcm
  ksshaskpass
  glibc-all-langpacks
)

PLASMA_OPTIONALS=(
  plasma-milou
  plasma-firewall
  plasma-thunderbolt
  plasma-wayland-protocols
  plasma-firewall-firewalld
  plasma-browser-integration
)

KIO_OPTIONALS=(
  kio-fuse
  kio-gdrive
)

KDE_GTK_BREEZE=(
  kde-gtk-config
  breeze-gtk-gtk3
  breeze-gtk-gtk4
)

REMOTE_ACCESS=(
  krdc
  krfb
  krdp
)

MISC_OPTIONALS=(
  orca
  espeak-ng
  kf6-baloo-file
  adwaita-fonts-all
  speech-dispatcher
  qt6-qtimageformats
  kde-inotify-survey
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
  kde-connect
  kinfocenter
  kde-partitionmanager
)

DOLPHIN_APPS=(
  ark
  dolphin
  dolphin-plugins
)

MISC_APPS=(
  code
  pods
  kcalc
  flatseal
  spectacle
  helium-drm
  pika-backup
  gnome-firmware
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
  "${XDG[@]}"
  "${PLASMA_BASE[@]}"
  "${KDE_BASE[@]}"
  "${PLASMA_BASE_MISC[@]}"
  "${KDE_ADDONS[@]}"
  "${PLASMA_ADDONS[@]}"
  "${SECURITY_MISC[@]}"
  "${KDE_EXTRAS[@]}"
  "${PLASMA_EXTRAS[@]}"
  "${MISC_EXTRAS[@]}"
  "${PLASMA_OPTIONALS[@]}"
  "${KIO_OPTIONALS[@]}"
  "${KDE_GTK_BREEZE[@]}"
  "${REMOTE_ACCESS[@]}"
  "${MISC_OPTIONALS[@]}"
  "${GHOSTTY[@]}"
  "${PLASMA_APPS[@]}"
  "${KDE_APPS[@]}"
  "${DOLPHIN_APPS[@]}"
  "${MISC_APPS[@]}"
  "${FCITX5[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"