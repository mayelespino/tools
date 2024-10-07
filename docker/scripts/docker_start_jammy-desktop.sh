#!/bin/bash

# https://hub.docker.com/r/kasmweb/ubuntu-jammy-desktop
# sudo docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password kasmweb/ubuntu-jammy-desktop:1.16.0
sudo docker run --rm -d --shm-size=512m -p 6901:6901 -e VNC_PW=password kasmweb/ubuntu-jammy-desktop:1.16.0
