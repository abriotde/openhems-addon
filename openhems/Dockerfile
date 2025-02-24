ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

RUN apk add --no-cache python3 py3-pip
COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY rootfs /

WORKDIR /

HEALTHCHECK --start-period=10m \
    CMD curl --fail http://127.0.0.1:8000 || exit 1

CMD ["python3", "/run.py"]
