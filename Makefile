# Makefile
SHELL := /bin/bash

init:
	source s3.env && terraform init

plan:
	source s3.env && terraform plan

apply:
	source s3.env && terraform apply

format:
	terraform fmt
