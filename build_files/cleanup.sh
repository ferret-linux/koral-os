#!/bin/bash

set -ouex pipefail

### Cleanup
dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:matinlotfali:KDE-Rounded-Corners.repo
dnf config-manager setopt ferret-pkgs.enabled=0
rm -f /etc/yum.repos.d/ferret-pkgs.repo
dnf5 autoremove -y
dnf5 clean all
dnf5 clean packages