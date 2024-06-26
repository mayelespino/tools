#!/bin/sh
sudo docker run --rm -it --name rust --mount type=bind,source="/home/mayel/GIT",target=/home rust:latest
