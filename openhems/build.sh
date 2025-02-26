#!/bin/bash

# docker build -t openhems-addon:main .

# Initialize Buildx (if not already done)
docker buildx create --use

if [ 0 == 1 ]; then
  # Build and push all architectures
  docker buildx build \
    --platform linux/amd64 \
    -t ghcr.io/abriotde/openhems-addon:0.1.14 \
    --push .
  exit
fi

docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t /data \
  -t openhems \
  -r https://github.com/abriotde/openhems-addon \
  -b main

#  -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
