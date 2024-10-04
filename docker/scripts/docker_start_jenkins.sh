#!/bin/sh
#sudo docker run -d --privileged -p 8000:8080 --name jenkins-1 --mount type=bind,source="/home/mayel/GIT",target=/home jenkins/jenkins:lts-jdk11
sudo docker run --add-host host.local.internal:host-gateway -d --privileged -p 8000:8080 --name jenkins-1 --mount type=bind,source="/home/mayel/",target=/var/jenkins_home/ jenkins/jenkins

echo "Now running:"
sudo docker ps
#
# links
# https://docs.docker.com/storage/bind-mounts/
# http://supermicro:8000/
# https://hub.docker.com/r/jenkins/jenkins
# https://github.com/jenkinsci/docker/blob/master/README.md
# https://www.jenkins.io/doc/book/pipeline/docker/
