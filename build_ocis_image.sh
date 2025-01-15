#!/bin/bash

DOCKER_REGISTRY=ociscloud/langfuse:241112

docker build -t $DOCKER_REGISTRY --build-arg NEXT_PUBLIC_BASE_PATH=/langfuse -f ./web/Dockerfile .
docker push $DOCKER_REGISTRY
