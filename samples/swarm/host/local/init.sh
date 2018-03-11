#!/bin/bash

# TODO: param to write tokens to

docker swarm init --advertise-addr $1

docker swarm join-token manager
