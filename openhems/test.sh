#!/bin/bash

# docker build -t openhems-addon:main .

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
