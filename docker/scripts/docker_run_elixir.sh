#!/bin/sh
sudo docker run --rm -it --name elixir --mount type=bind,source="/home/mayel/GIT",target=/home elixir:latest

