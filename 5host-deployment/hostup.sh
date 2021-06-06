#!/bin/bash
cd /mydata/fabric/fabric-samples/5host-deployment
docker-compose -f host$1.yaml up -d
