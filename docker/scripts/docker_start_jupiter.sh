docker run -d -i -t -p 8888:8888 --mount type=bind,source="/home/mayel/GIT/jupiter",target=/home continuumio/anaconda3 /bin/bash -c "conda install jupyter -y --quiet &&  jupyter notebook --notebook-dir=/home --ip='*' --port=8888 --no-browser --allow-root"
