#!/bin/bash

# docker build -t openhems-addon:main .

# Initialize Buildx (if not already done)
docker buildx create --use

# Build and push all architectures
docker buildx build \
  --platform linux/amd64 \
  -t ghcr.io/abriotde/openhems-addon:latest \
  --push .

exit

docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t /data \
  --push
  # -t openhems \
  # -r https://github.com/abriotde/openhems-addon \
  # -b main

#  -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
