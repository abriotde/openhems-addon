ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.9
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# We need to copy in the patches need during build
# COPY rootfs/patches /patches

# Setup base
# hadolint ignore=DL3003,DL3042
RUN apk upgrade --no-cache
RUN apk add --no-cache --virtual .build-dependencies python3-dev=3.11.11-r0
RUN apk add --no-cache \
        py3-pip=23.3.1-r0 \
        py3-wheel=0.42.0-r0 \
        python3=3.11.11-r0
RUN pip install -r /tmp/requirements.txt
RUN find /usr \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' +
RUN apk del --no-cache --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Alberic de la Crochais <contact@openhomesystem.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="OpenHomeSystem" \
    org.opencontainers.image.authors="Alberic de la Crochais <contact@openhomesystem.com>" \
    org.opencontainers.image.licenses="GPLv3" \
    org.opencontainers.image.url="https://openhomesystem.com/pourquoi-choisir-la-solution-openhems/" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

EXPOSE 8000

CMD ["python3", "", "", ""]
