#!/bin/bash

output=$(terraform output postgre_private_ip)
# If the main terraform file is not successfully run, the s3-backend infra is to be destroyed.

if [[ ! -z "$output" ]]; then
	cd ./s3-backend && terraform destroy -auto-approve
fi