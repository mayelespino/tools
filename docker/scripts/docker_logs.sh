#!/bin/bash
container=`sudo docker images | grep -i $1 | awk '{print $3;}'`
sudo docker logs $container
