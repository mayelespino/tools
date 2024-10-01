#!/bin/bash
# https://hub.docker.com/_/cassandra
# Starting a Cassandra instance is simple:
sudo docker run --name me-cass --network me-cass-network -d cassandra:latest
# Connect to Cassandra from cqlsh
sudo docker run -it --network me-cass-network --rm cassandra cqlsh me-cass
