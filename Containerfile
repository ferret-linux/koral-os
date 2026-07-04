ARG BASE_IMAGE

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ${BASE_IMAGE}

ARG IMAGE_NAME
ARG IMAGE_VENDOR="ferret-linux"
ARG IMAGE_TAG="latest"

### OS Release
RUN sed -i 's/^NAME=.*/NAME="KoralOS"/' /usr/lib/os-release && \
    sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="KoralOS Linux"/' /usr/lib/os-release

## Add Repos
RUN dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners && \
    dnf config-manager addrepo --from-repofile=https://ferretlinux.org/repo/ferret-pkgs.repo && \
    dnf config-manager setopt ferret-pkgs.enabled=1 && \
    dnf config-manager setopt ferret-pkgs.priority=90 && \
    dnf --refresh makecache && \
    dnf upgrade --setopt=intall_weak_deps=false

# Make /opt real dir before package install
RUN rm -rf /opt && mkdir -p /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/packages.sh

# Move /opt contents to immutable tree, create tmpfiles.d entries, fix dirs
RUN mkdir -p /usr/lib/opt && \
    mv /opt/* /usr/lib/opt/ 2>/dev/null || true && \
    for dir in /usr/lib/opt/*/; do \
        opt=$(basename "$dir"); \
        echo "L+?  \"/opt/${opt}\"  -  -  -  -  /usr/lib/opt/${opt}" > /usr/lib/tmpfiles.d/99-optfix-${opt}.conf; \
    done && \
    rm -rf /opt && ln -s /var/opt /opt && \
    mkdir -p /var/roothome && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp

# Cleanup
RUN dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners && \
    rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:matinlotfali:KDE-Rounded-Corners.repo && \
    dnf config-manager setopt ferret-pkgs.enabled=0 && \
    rm -f /etc/yum.repos.d/ferret-pkgs.repo && \
    dnf5 autoremove -y && \
    dnf5 clean all && \
    dnf5 clean packages

# Copy system files
COPY system_files/ /

# Build InitRamFS
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/initrafs.sh
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint