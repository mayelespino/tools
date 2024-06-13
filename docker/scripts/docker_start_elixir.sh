#!/bin/sh
sudo docker run -d -it --name elixir --mount type=bind,source="/home/mayel/GIT",target=/home elixir:latest

echo "Now running:"
sudo docker ps
#
# links
# https://docs.docker.com/storage/bind-mounts/
