#!/usr/bin/env bash

echo "Building from local Dockerfile"
echo "Name: nnabla_jupyter"
echo "Tag: latest"

docker build -t nnabla_jupyter_gpu:latest .