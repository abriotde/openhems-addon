ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.0
FROM ${BUILD_FROM}

# Update repositories and packages
RUN apk update && apk upgrade


RUN apk add --no-cache --virtual .build-dependencies \
    musl=1.2.4-r3 \
    musl-dev=1.2.4-r3
# --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
# Install system dependencies
RUN apk add --no-cache \
    python3 python3-dev \
    py3-pip \
    ninja \
    gcc \
    make \
    libc-dev \
    linux-headers \
    openblas-dev \
    build-base \
    libgomp \
    hdf5-dev \
    llvm-dev \
    py3-wheel \
    pkgconfig


# Upgrade pip
RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install numpy

# Install Python packages
COPY requirements.txt /
RUN pip3 install --no-cache-dir --prefer-binary -r /requirements.txt

RUN mkdir -p /log /app/config

COPY rootfs /

WORKDIR /
EXPOSE 8000

HEALTHCHECK --start-period=10m \
    CMD curl --fail http://127.0.0.1:8000 || exit 1

CMD ["/run.sh"]
