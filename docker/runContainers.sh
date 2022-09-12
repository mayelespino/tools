#!/bin/bash

sudo docker run -d -it --name code --mount type=bind,source="/home/mayel/GIT",target=/home/mayel ubuntu:latest
