#!/bin/sh

sleep 5s

token=$(cat /vagrant/.docker/swarm/$2.token)
docker swarm join --token $token $1:2377
