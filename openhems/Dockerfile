ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

RUN apk add --no-cache python3 py3-pip

# Copy root filesystem
COPY rootfs /
COPY requirements.txt /
RUN pip3 install -r /requirements.txt

WORKDIR /data

CMD ["python3", "/run.py"]
