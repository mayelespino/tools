# How to run containers

  872  docker run -it ros:latest /bin/bash
  873  docker images
  874  docker rmi ros:latest
  876  sudo docker build -t ros - < Dockerfile
  877  docker run -it ros:latest /bin/bash
  882  sudo docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password kasmweb/ubuntu-jammy-desktop:1.16.0
  883  docker ps
  884  docker images
  895  cd docker/
  901  vi docker_start_jammy-desktop.sh
  903  git commit -m "addes docker_start_jammy-desktop.sh"
  947  docker pull tiryoh/ros2-desktop-vnc
  948  docker run -p 6080:80 --shm-size=512m tiryoh/ros2-desktop-vnc:foxy
 1037  docker container ls
 1038  docker images
 1041  docker run -it ros:latest /bin/bash
 1044  docker run --rm --net host -v /tmp/.X11-unix:/tmp/.X11-unix -it ros:latest /bin/bash
