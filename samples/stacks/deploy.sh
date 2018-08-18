#!/bin/sh

# touch $1/docker-compose.override.yml
# docker stack deploy --compose-file $1/docker-compose.yml --compose-file $1/docker-compose.override.yml $1
docker stack deploy --compose-file $1/docker-compose.yml $1
