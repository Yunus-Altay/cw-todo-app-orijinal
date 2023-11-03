#!/bin/bash

output=$(terraform output postgre_private_ip)
# If the terraform file is not successfully run, the other tf file is to be destroyed.

if [[ ! -z "$output" ]]; then
	cd ./s3-backend && terraform destroy -auto-approve
fi