#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

EDITORS_IDE=(
  code
)

CONTAINER_TOOLING=(
  pods
  podman
  buildah
)

VERSION_CONTROL=(
  git
  git-lfs
  gh
)

ANDROID_TESTING=(
  waydroid
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${EDITORS_IDE[@]}"
  "${CONTAINER_TOOLING[@]}"
  "${VERSION_CONTROL[@]}"
  "${ANDROID_TESTING[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"