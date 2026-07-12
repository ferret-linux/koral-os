#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

GAME_LAUNCHERS=(
  steam
  steam-devices
  retroarch
  protonplus
  heroic-games-launcher
)

LUTRIS_WINE=(
  lutris
  wine
  winetricks
)

BOTTLES_RUNTIME=(
  bottles
)

PERFORMANCE_OVERLAY=(
  mangohud
  goverlay
  gamemode
  gamescope
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${GAME_LAUNCHERS[@]}"
  "${LUTRIS_WINE[@]}"
  "${BOTTLES_RUNTIME[@]}"
  "${PERFORMANCE_OVERLAY[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"