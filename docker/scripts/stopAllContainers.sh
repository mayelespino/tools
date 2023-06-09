#!/bin/bash

array=( ubuntu golang rust python )
for i in "${array[@]}"
do
    sudo docker container stop "$i"
    sudo docker rm "$i"
done
