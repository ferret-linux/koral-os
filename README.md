# KoralOS

A KDE Plasma desktop built on top of [Mink OS](https://github.com/ferret-linux/mink-os) using bootc.

## Installation

```bash
bootc switch ghcr.io/ferret-linux/koral-os:latest
```

## Variants

- `koral-os` — standard
- `koral-os-nvidia` — with NVIDIA drivers

## Verification

```bash
cosign verify --key cosign.pub ghcr.io/ferret-linux/koral-os:latest
```
