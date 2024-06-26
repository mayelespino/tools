#!/bin/sh
sudo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME/GIT/tools/docker/lazydocker":/.config/jesseduffield/lazydocker lazyteam/lazydocker

echo "Now running:"
sudo docker ps
