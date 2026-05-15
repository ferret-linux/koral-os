#!/bin/bash

set -ouex pipefail

### Install plasma base
dnf5 install -y --setopt=install_weak_deps=False \
    xdg-utils \
    xdg-user-dirs \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-kde \
    plasma-nm \
    plasma-pa \
    plasma-workspace \
    plasma-desktop \
    plasma-integration \
    plasma-activities \
    plasma-lookandfeel-fedora \
    kwayland-integration \
    kunifiedpush \
    kde-settings-plasma \
    bluedevil \
    powerdevil \
    ffmpegthumbs \
    kscreen \
    kscreenlocker \
    plasma-login-manager \
    plasma-keyboard

### Install plasma addons
dnf5 install -y --setopt=install_weak_deps=False \
    kdenetwork-filesharing \
    kdeplasma-addons \
    plasma-nm-openvpn \
    plasma-nm-openconnect \
    plasma-vault \
    plasma-disks \
    pinentry-qt \
    pam-kwallet \
    signon-kwallet-extension \
    polkit-kde \
    kdegraphics-thumbnailers \
    switcheroo-control

### Install plasma extras (with KDE Rounded Corners)
dnf5 install -y --setopt=install_weak_deps=False \
    kwin-effect-roundcorners \
    plasma-print-manager \
    kio-admin \
    colord-kde \
    kdnssd \
    ksshaskpass \
    ldns \
    nss-tools \
    glibc-all-langpacks \
    flatpak-kcm \
    kcm-plasma-keyboard \
    kcm-plasmalogin

### Install plasma optionals
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-milou \
    kio-gdrive \
    kio-fuse \
    plasma-browser-integration \
    plasma-wayland-protocols \
    plasma-thunderbolt \
    kde-gtk-config \
    breeze-gtk-gtk4 \
    breeze-gtk-gtk3 \
    plasma-firewall-firewalld \
    plasma-firewall \
    kf6-baloo-file \
    qt6-qtimageformats \
    krfb \
    krdc \
    adwaita-fonts-all \
    orca \
    speech-dispatcher \
    espeak-ng \
    kde-inotify-survey

### Install plasma apps
dnf5 install -y --setopt=install_weak_deps=False \
    dolphin \
    dolphin-plugins \
    ark \
    spectacle \
    ghostty \
    kde-partitionmanager \
    kde-connect \
    plasma-systemsettings \
    plasma-systemmonitor \
    plasma-discover-kns \
    plasma-discover-notifier \
    plasma-discover-flatpak \
    plasma-discover \
    kinfocenter \
    input-remapper

### Install input methods (fcitx5)
dnf5 install -y --setopt=install_weak_deps=False \
    kcm-fcitx5 \
    fcitx5 \
    fcitx5-gtk \
    fcitx5-qt6 \
    fcitx5-configtool \
    fcitx5-mozc \
    fcitx5-chewing \
    fcitx5-chinese-addons \
    fcitx5-hangul \
    fcitx5-unikey \
    fcitx5-m17n \
    fcitx5-libthai \
    fcitx5-table-extra \
    fcitx5-rime

### Enable system services
systemctl enable plasmalogin.service
systemctl enable switcheroo-control.service