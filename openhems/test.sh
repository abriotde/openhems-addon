#!/bin/bash


docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems
#  -r https://github.com/abriotde/openhems-addon \
#  -b main

