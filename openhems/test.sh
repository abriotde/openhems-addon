#!/bin/bash


docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t openhems \
  -r https://github.com/abriotde/openhems-addon \
  -b main

