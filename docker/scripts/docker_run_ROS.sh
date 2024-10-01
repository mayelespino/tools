#!/bin/sh
sudo docker run -d -it --rm --name master --net ros-net --mount type=bind,source="/home/mayel/GIT",target=/home  my/ros:app

echo "Now running:"
sudo docker ps
