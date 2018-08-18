#!/bin/sh

export MACHINE_STORAGE_PATH=$pwd

docker-machine env $1
