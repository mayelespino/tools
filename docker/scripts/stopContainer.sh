#!/bin/bash

sudo docker container stop "$1"
sudo docker rm "$1"
