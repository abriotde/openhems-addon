#!/bin/bash

ARG=$1

if [ "$ARG" == "build" ]; then
  docker build -t openhems-addon:main .
else if [ "$ARG" == "buildx" ]; then
  # Initialize Buildx (if not already done)
	docker buildx create --use

  # Build and push all architectures
  docker buildx build \
    --platform linux/amd64 \
    -t ghcr.io/abriotde/openhems-addon:0.1.14 \
    --push .
  exit
else if [ "$ARG" == "run" ]; then
  docker run \
    --rm \
    --privileged \
    -v ~/.docker:/root/.docker \
    ghcr.io/home-assistant/amd64-builder \
    --all \
    -t openhems \
    -r https://github.com/abriotde/openhems-addon \
    -b main
  #  -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
else
  echo "Missing or wrong argument ($ARG) expecting 'build', 'buildx', or 'run'"
fi; fi; fi
