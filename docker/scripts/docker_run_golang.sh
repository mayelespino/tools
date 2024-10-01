#!/bin/sh
sudo docker run --rm -it --name golang --mount type=bind,source="/home/mayel/GIT",target=/home golang:latest

