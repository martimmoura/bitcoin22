#!/bin/bash
echo logging in to ecr repo

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 982065454085.dkr.ecr.us-east-2.amazonaws.com

echo  tagging image with $1

docker tag btc22 982065454085.dkr.ecr.us-east-2.amazonaws.com/btc22:$1
docker tag btc22 982065454085.dkr.ecr.us-east-2.amazonaws.com/btc22

docker push 982065454085.dkr.ecr.us-east-2.amazonaws.com/btc22:$1
docker push 982065454085.dkr.ecr.us-east-2.amazonaws.com/btc22
