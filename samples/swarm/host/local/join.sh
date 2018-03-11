#!/bin/bash

docker swarm join --token $2 $1:2377
