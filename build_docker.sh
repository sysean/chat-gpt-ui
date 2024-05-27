#!/bin/zsh

docker buildx build --platform linux/amd64 -t paulyung/chatgpt-ui:latest --push .
