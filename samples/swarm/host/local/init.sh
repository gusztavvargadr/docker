#!/bin/sh

docker swarm init --advertise-addr $1

mkdir -p /vagrant/.docker/swarm

docker swarm join-token -q manager > /vagrant/.docker/swarm/manager.token
docker swarm join-token -q worker > /vagrant/.docker/swarm/worker.token
