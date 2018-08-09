#!/bin/sh

docker stack deploy -c $1/docker-compose.yml $1
