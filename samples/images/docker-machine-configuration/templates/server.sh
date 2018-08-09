#!/bin/sh

cp .docker/machine/machines/$1/ca.pem /etc/docker
cp .docker/machine/machines/$1/server.pem /etc/docker
cp .docker/machine/machines/$1/server-key.pem /etc/docker

sed -i -- 's/ExecStart=\/usr\/bin\/dockerd -H fd:\/\//ExecStart=\/usr\/bin\/dockerd/g' /lib/systemd/system/docker.service
cp .docker/machine/machines/$1/server.linux.json /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker
