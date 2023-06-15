#!/bin/sh
#
if [ -z "$1" ]
then
    echo "pass in an image id."
    sudo docker images
    exit 0
fi
sudo docker rmi -f "$1"
