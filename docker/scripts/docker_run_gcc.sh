#!/bin/sh
# sudo docker run -d -it --name gcc --mount type=bind,source="/home/mayel/GIT",target=/home gcc:latest
sudo docker run --rm -it --name gcc --mount type=bind,source="/home/mayel/GIT",target=/home gcc:latest

echo "Now running:"
sudo docker ps
#
# links
# https://docs.docker.com/storage/bind-mounts/
