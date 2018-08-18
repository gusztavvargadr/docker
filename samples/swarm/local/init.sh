#!/bin/sh

docker swarm init --advertise-addr $1

mkdir -p /data/docker/swarm

docker swarm join-token -q manager > /data/docker/swarm/manager.token
docker swarm join-token -q worker > /data/docker/swarm/worker.token
