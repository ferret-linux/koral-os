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

GHOSTTY=(
  ghostty
  ghostty-zsh-completion
  ghostty-shell-integration
)

DOLPHIN_APPS=(
  ark
  dolphin
  dolphin-plugins
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
  "${GHOSTTY[@]}"
  "${DOLPHIN_APPS[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"