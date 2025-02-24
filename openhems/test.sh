#!/bin/bash

# docker build -t openhems-addon:main .

docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t /data
#  -r https://github.com/abriotde/openhems-addon \
#  -b main

