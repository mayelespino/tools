#!/bin/bash

array=( ubuntu golang rust python )
for i in "${array[@]}"
do
    sudo docker run -d -it --name "$i" --mount type=bind,source="/home/mayel/GIT",target=/home/mayel "$i":latest
done
