ARG BASE_IMAGE

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ${BASE_IMAGE}

ARG IMAGE_NAME
ARG IMAGE_VENDOR="ferret-linux"
ARG IMAGE_TAG="latest"

# Make /opt real dir before package install
RUN rm -rf /opt && mkdir -p /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/build.sh

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

# Copy system files
COPY system_files/ /

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint