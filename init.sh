#!/bin/bash

script=$2
numServers=$1


for ((i=0;i<numServers;i++)); do
      

	echo "*******************************************"
	echo "*******************************************"
    echo "******************* node$i ********************"
    echo "*******************************************"
    echo "*******************************************"
	sudo ssh -oStrictHostKeyChecking=no node$i "sudo apt-get update"
    sudo ssh -oStrictHostKeyChecking=no node$i "sudo apt-get --yes install screen"
    sudo ssh -n -f -oStrictHostKeyChecking=no node$i screen -L -S env1 -dm "$script"

done
sleepcount="0"
for ((i=0;i<numServers;i++)); 
do
	while sudo ssh -oStrictHostKeyChecking=no  node$i "screen -list | grep -q env1"
	do 
		((sleepcount++))
		sleep 60
		echo "waiting for node$i"
	done

done

echo "init env took $sleepcount minutes"
