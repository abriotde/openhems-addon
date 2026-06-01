#!/bin/bash

ARG=$1
VERSION=`cat config.yaml | ./shyaml.py get-value version`
OPENHEMS_PATH=/home/alberic/Documents/OpenHomeSystem/openhems-sample/config/
OPENHEMS_LOGPATH=/var/log/openhems/

if [ "$ARG" == "build" ]; then
  docker build --build-arg TARGETARCH=amd64 -t openhems-addon:$VERSION .
else if [ "$ARG" == "push" ]; then
  docker login ghcr.io
  docker tag ghcr.io/abriotde/openhems-addon:latest ghcr.io/abriotde/openhems-addon:$VERSION
  docker push ghcr.io/abriotde/openhems-addon:$VERSION
else if [ "$ARG" == "buildx" ]; then
  # Initialize Buildx (if not already done)
	docker buildx create --use

  # Build and push all architectures
  docker buildx build \
    --platform linux/amd64 \
    -t ghcr.io/abriotde/openhems-addon:$VERSION \
    --push .
else if [ "$ARG" == "run0" ]; then
  # https://developers.home-assistant.io/docs/add-ons/publishing/
  docker run \
        --rm \
        --privileged \
        -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -v /home/alberic/Documents/OpenHomeSystem/openhems-addon/openhems:/data \
        ghcr.io/home-assistant/amd64-builder \
        --amd64 \
        -t /data
    # -t openhems \
    # -r https://github.com/abriotde/openhems-addon \
    # -b main
else if [ "$ARG" == "run" ]; then
  docker run -p 8000:8000 \
          -v $OPENHEMS_PATH/config:/app/config \
          -v $OPENHEMS_LOGPATH:/log \
          openhems-addon:$VERSION
else
  echo "Missing or wrong argument ($ARG) expecting 'build', 'buildx', or 'run'"
fi; fi; fi; fi; fi
