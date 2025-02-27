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
  # https://developers.home-assistant.io/docs/add-ons/publishing/
  docker run \
    --rm \
    --privileged \
    -v ~/.docker:/root/.docker \
    ghcr.io/home-assistant/amd64-builder \
    -t /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
    --all \
    -t /data
    # -t openhems \
    # -r https://github.com/abriotde/openhems-addon \
    # -b main
else
  echo "Missing or wrong argument ($ARG) expecting 'build', 'buildx', or 'run'"
fi; fi; fi
