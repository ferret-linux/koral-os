#!/bin/bash

set -ouex pipefail

### Setup ferret-pkgs repo & Copr's
dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners
dnf config-manager addrepo --from-repofile=https://ferretlinux.org/repo/ferret-pkgs.repo
dnf config-manager setopt ferret-pkgs.enabled=1
dnf config-manager setopt ferret-pkgs.priority=90
dnf --refresh makecache

### OS Release
sed -i 's/^NAME=.*/NAME="KoralOS"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="KoralOS Linux"/' /usr/lib/os-release