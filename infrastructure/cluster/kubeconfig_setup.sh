#!/bin/bash


aws eks list-clusters--region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name) --profile martim


aws eks list-clusters--region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name) --profile martim
