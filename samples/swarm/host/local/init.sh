#!/bin/bash

docker swarm init --advertise-addr $1

docker swarm join-token manager
