## EMHASS Docker
## Docker run addon testing example:
    ## docker build -t emhass .
    ## OR docker build --build-arg TARGETARCH=amd64 -t emhass .
    ## docker run --rm -it -p 5000:5000 --name emhass-container -v ./config.json:/share/config.json -v ./secrets_emhass.yaml:/app/secrets_emhass.yaml emhass

# armhf,amd64,armv7,aarch64
ARG TARGETARCH
# armhf=raspbian, amd64,armv7,aarch64=debian
ARG os_version=debian

FROM ghcr.io/home-assistant/$TARGETARCH-base-$os_version:bookworm AS base

# check if TARGETARCH was passed by build-arg
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH:?}

WORKDIR /app
COPY requirements.txt /app/

# apt package install
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libffi-dev \
    python3.11 \
    python3-pip \
    python3.11-dev \
    git \
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
    libatlas3-base \
    libatlas-base-dev \
    libopenblas-dev \
    libopenblas0-pthread \
    libgfortran5 \
    libsz2 \
    libaec0 \
    libhdf5-hl-100 \
    libhdf5-103-1
# specify hdf5
RUN ln -s /usr/include/hdf5/serial /usr/include/hdf5/include && export HDF5_DIR=/usr/include/hdf5

# note, its a good idea to remove the "llvm-dev" package and "LLVM_CONFIG=/usr/bin/llvm-config pip3 install 'llvmlite>=0.43'" once the llvmlite package has been fixed in piwheels
RUN [[ "${TARGETARCH}" == "armhf" || "${TARGETARCH}" == "armv7" ]] && apt-get update && apt-get install -y --no-install-recommends llvm-dev && LLVM_CONFIG=/usr/bin/llvm-config pip3 install --no-cache-dir --break-system-packages 'llvmlite>=0.43' ||  echo "skipping llvm-dev install"

# install packages from pip, use piwheels if arm 32bit
RUN [[ "${TARGETARCH}" == "armhf" || "${TARGETARCH}" == "armv7" ]] && pip3 install --index-url=https://www.piwheels.org/simple --no-cache-dir --break-system-packages -r /app/requirements.txt ||  pip3 install --no-cache-dir --break-system-packages -r /app/requirements.txt

# try, symlink apt cbc, to pulp cbc, in python directory (for 32bit)
RUN [[ "${TARGETARCH}" == "armhf" || "${TARGETARCH}" == "armv7"  ]] &&  ln -sf /usr/bin/cbc /usr/local/lib/python3.11/dist-packages/pulp/solverdir/cbc/linux/32/cbc || echo "cbc symlink didnt work/not required"

# if armv7, try install libatomic1 to fix scipy issue
RUN [[ "${TARGETARCH}" == "armv7" ]] && apt-get update && apt-get install libatomic1 || echo "libatomic1 cant be installed"

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
