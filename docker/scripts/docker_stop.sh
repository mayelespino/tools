#!/bin/sh
#
if [ -z "$1" ]
then
    echo "pass in a contaner NAME, not id."
    sudo docker ps
    exit 0
fi
sudo docker stop -f "$1"
sudo docker rm "$1"
