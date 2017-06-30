#!/bin/bash
cd service

export FULL_IMAGE_NAME=registry.ng.bluemix.net/jpenaur/mytodos:v1
echo "Using Docker image ${FULL_IMAGE_NAME}"
docker build -t ${FULL_IMAGE_NAME} .
docker push ${FULL_IMAGE_NAME}