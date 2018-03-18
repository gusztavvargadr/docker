#!/bin/sh

cp .docker/machine/machines/$1/ca.pem /etc/docker
cp .docker/machine/machines/$1/server.pem /etc/docker
cp .docker/machine/machines/$1/server-key.pem /etc/docker

cp .docker/machine/machines/$1/docker /etc/default

service docker restart
