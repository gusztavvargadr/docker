#!/bin/sh

export TF_VAR_domain=$1
export TF_VAR_machines=$2
export TF_VAR_path=$3

terraform apply -auto-approve
