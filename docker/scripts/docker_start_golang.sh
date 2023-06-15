#!/bin/sh
sudo docker run -d -it --name golang --mount type=bind,source="/home/mayel/GIT",target=/home rust:latest

echo "Now running:"
sudo docker ps
#
# links
# https://docs.docker.com/storage/bind-mounts/
