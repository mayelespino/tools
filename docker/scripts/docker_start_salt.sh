#!/bin/sh
#
if [ -z "$1" ]
then
    echo "pass in a contaner NAME, not id."
    sudo docker ps
    exit 0
fi
# https://docs.saltproject.io/en/latest/topics/tutorials/quickstart.html
# sudo docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /etc/salt/master.d -v /srv/salt --name salt-master-data busybox true
# sudo docker run --rm -it --volume-from salt-master-data soon/salt-master

