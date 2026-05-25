## EMHASS Docker
## Docker run addon testing example:
    ## docker build -t emhass .
    ## OR docker build --build-arg TARGETARCH=amd64 -t emhass .
    ## docker run --rm -it -p 5000:5000 --name emhass-container -v ./config.json:/share/config.json -v ./secrets_emhass.yaml:/app/secrets_emhass.yaml emhass

# armhf,amd64,armv7,aarch64
ARG TARGETARCH
# armhf=raspbian, amd64,armv7,aarch64=debian
ARG os_version

FROM ghcr.io/home-assistant/base-debian:trixie AS base

# check if TARGETARCH was passed by build-arg
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH:?}

WORKDIR /app
COPY requirements.txt /app/

# Installation des dépendances système nécessaires (beaucoup sont déjà présentes)
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libffi-dev \
  gcc \
  patchelf \
  cmake \
  meson \
  ninja-build \
  build-essential \
  libhdf5-dev \
  libhdf5-serial-dev \
  pkg-config \
  gfortran \
  netcdf-bin \
  libnetcdf-dev \
  coinor-cbc \
  coinor-libcbc-dev \
  libglpk-dev \
  glpk-utils \
  libopenblas-dev \
  python3.13-venv python3-pip
# specify hdf5
RUN ln -s /usr/include/hdf5/serial /usr/include/hdf5/include && export HDF5_DIR=/usr/include/hdf5

# install packages from pip, use piwheels if arm 32bit
RUN pip install --break-system-packages -r /app/requirements.txt

# remove build only packages
RUN apt-get purge -y --auto-remove \
    gcc \
    patchelf \
    cmake \
    meson \
    ninja-build \
    build-essential \
    pkg-config \
    gfortran \
    netcdf-bin \
    libnetcdf-dev \
    && rm -rf /var/lib/apt/lists/*

# make sure data directory exists
RUN mkdir -p /app/data/

# make sure share directory exists
RUN mkdir -p /share/openhems/ /var/log/openhems/

# pre generated optimization results 
COPY README.md /app/
COPY rootfs /

# secrets file (secrets_emhass.yaml) can be copied into the container with volume mounts with docker run
# options.json file will be automatically generated and passed from Home Assistant using the addon

#set python env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Docker Labels for hass
LABEL \
    io.hass.name="openhems" \
    io.hass.description="OpenHEMS: Home Energy Management System for Home Assistant" \
    io.hass.type="addon" \
    io.hass.arch="aarch64|amd64|armhf|armv7" \
    org.opencontainers.image.source="https://github.com/abriotde/openhems-sample" \
    org.opencontainers.image.description="OpenHEMS python package and requirements, in Home Assistant Debian container."
#    io.hass.version=${BUILD_VERSION}

# RUN pip3 install --no-cache-dir --break-system-packages --no-deps --force-reinstall  .

WORKDIR /
EXPOSE 8000

HEALTHCHECK --start-period=10m \
    CMD curl --fail http://127.0.0.1:8000 || exit 1

CMD [ "/app/run.sh" ]

# for running Unittest
#COPY tests/ /app/tests
#RUN apt-get update &&  apt-get install python3-requests-mock -y
#COPY data/ /app/data/
#ENTRYPOINT ["python3","-m","unittest","discover","-s","./tests","-p","test_*.py"]
