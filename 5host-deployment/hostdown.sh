#!/bin/bash
cd /mydata/fabric/fabric-samples/5host-deployment
docker-compose -f host$1.yaml down -v
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
