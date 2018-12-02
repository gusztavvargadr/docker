#!/bin/sh

cp machines/$1/ca.pem /etc/docker
cp machines/$1/server.pem /etc/docker
cp machines/$1/server-key.pem /etc/docker

sed -i -- 's/ExecStart=\/usr\/bin\/dockerd -H unix:\/\//ExecStart=\/usr\/bin\/dockerd/g' /lib/systemd/system/docker.service
cp machines/$1/server.linux.json /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker
