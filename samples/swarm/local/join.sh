#!/bin/sh

token=$(cat /data/docker/swarm/$2.token)
docker swarm join --token $token $1:2377
