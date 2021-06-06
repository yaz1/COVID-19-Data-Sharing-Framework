#!/bin/bash

mod=$2
numServers=$1

path="/mydata/fabric/fabric-samples/5host-deployment/"




for ((i=0;i<numServers;i++)); do

echo "******************* node$i $mod********************"

sudo ssh -n -f -oStrictHostKeyChecking=no node$i "$path/host$mod.sh $i"




done

 


