#!/bin/bash

set -ouex pipefail

### Plasma base — xdg
dnf5 install -y --setopt=install_weak_deps=False \
    xdg-utils \
    xdg-user-dirs \
    xdg-user-dirs-gtk \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-kde

### Plasma base — plasma
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-nm \
    plasma-pa \
    plasma-setup \
    plasma-desktop \
    plasma-keyboard \
    plasma-workspace \
    plasma-activities \
    plasma-integration \
    plasma-login-manager \
    plasma-lookandfeel-fedora

### Plasma base — kde/k
dnf5 install -y --setopt=install_weak_deps=False \
    kscreen \
    kunifiedpush \
    kscreenlocker \
    kde-settings-plasma \
    kwayland-integration

### Plasma base — misc
dnf5 install -y --setopt=install_weak_deps=False \
    bluedevil \
    powerdevil \
    ffmpegthumbs

### Plasma addons — kde
dnf5 install -y --setopt=install_weak_deps=False \
    kdeplasma-addons \
    kdenetwork-filesharing \
    kdegraphics-thumbnailers

### Plasma addons — plasma
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-vault \
    plasma-disks \
    plasma-nm-openvpn \
    plasma-nm-openconnect

### Plasma addons — security/misc
dnf5 install -y --setopt=install_weak_deps=False \
    kwallet \
    polkit-kde \
    pam-kwallet \
    pinentry-qt \
    switcheroo-control \
    signon-kwallet-extension

### Plasma extras — kde/k
dnf5 install -y --setopt=install_weak_deps=False \
    kio-admin \
    kcm-plasmalogin \
    kcm-plasma-keyboard \
    kwin-effect-roundcorners

### Plasma extras — plasma
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-print-manager

### Plasma extras — misc
dnf5 install -y --setopt=install_weak_deps=False \
    ldns \
    kdnssd \
    nss-tools \
    colord-kde \
    flatpak-kcm \
    ksshaskpass \
    glibc-all-langpacks

### Plasma optionals — plasma
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-milou \
    plasma-firewall \
    plasma-thunderbolt \
    plasma-wayland-protocols \
    plasma-firewall-firewalld \
    plasma-browser-integration

### Plasma optionals — kio
dnf5 install -y --setopt=install_weak_deps=False \
    kio-fuse \
    kio-gdrive

### Plasma optionals — kde-gtk/breeze
dnf5 install -y --setopt=install_weak_deps=False \
    kde-gtk-config \
    breeze-gtk-gtk3 \
    breeze-gtk-gtk4

### Plasma optionals — remote access
dnf5 install -y --setopt=install_weak_deps=False \
    krdc \
    krfb \
    krdp

### Plasma optionals — misc
dnf5 install -y --setopt=install_weak_deps=False \
    orca \
    espeak-ng \
    kf6-baloo-file \
    adwaita-fonts-all \
    speech-dispatcher \
    qt6-qtimageformats \
    kde-inotify-survey

### Ghostty terminal
dnf5 install -y --setopt=install_weak_deps=False \
    ghostty \
    ghostty-kio \
    ghostty-neovim \
    ghostty-terminfo \
    ghostty-bat-syntax \
    ghostty-zsh-completion \
    ghostty-shell-integration

### Plasma apps — plasma
dnf5 install -y --setopt=install_weak_deps=False \
    plasma-discover \
    plasma-discover-kns \
    plasma-systemmonitor \
    plasma-systemsettings \
    plasma-discover-flatpak \
    plasma-discover-notifier

### Plasma apps — kde
dnf5 install -y --setopt=install_weak_deps=False \
    kde-connect \
    kinfocenter \
    kde-partitionmanager

### Plasma apps — dolphin
dnf5 install -y --setopt=install_weak_deps=False \
    ark \
    dolphin \
    dolphin-plugins

### Plasma apps — misc
dnf5 install -y --setopt=install_weak_deps=False \
    code \
    pods \
    kcalc \
    flatseal \
    spectacle \
    pika-backup \
    gnome-firmware \
    input-remapper

### Input methods (fcitx5)
dnf5 install -y --setopt=install_weak_deps=False \
    fcitx5 \
    fcitx5-gtk \
    fcitx5-qt6 \
    kcm-fcitx5 \
    fcitx5-mozc \
    fcitx5-m17n \
    fcitx5-rime \
    fcitx5-hangul \
    fcitx5-unikey \
    fcitx5-chewing \
    fcitx5-libthai \
    fcitx5-configtool \
    fcitx5-table-extra \
    fcitx5-chinese-addons

### Enable system services
systemctl enable plasmalogin.service
systemctl enable plasma-setup.service
systemctl enable switcheroo-control.service