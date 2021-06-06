#!/bin/bash

numServers=$1

docker swarm leave --force
docker swarm init --advertise-addr "10.10.1.1"
#extra=" --advertise-addr "$(ip addr show eno1d1 | grep -Po 'inet \K[\d.]+')""
m=$(docker swarm join-token manager)
m=$(echo $m | cut -d ":" -f 2,3)
w=$(docker swarm join-token worker)
w=$(echo $w | cut -d ":" -f 2,3)




#docker swarm join --token SWMTKN-1-5kxasq7zhk9m5whg47i18y5ypny0kpqsf00s2e666uzs6fqk9f-4601dscfw8gk2o4a472em5d5d 10.10.1.1:2377 --advertise-addr "$(ip addr show eno1d1 | grep -Po 'inet \K[\d.]+')"

for ((i=1;i<numServers;i++)); do
      
   
    
    extra=" --advertise-addr 10.10.1.$((i+1))"
	if [ $i -lt 100 ] 
         then
         command=$m$extra
         echo "******************* node$i Manager ********************"
        else
        command=$w$extra
        echo "******************* node$i Worker********************"
        fi

    sudo ssh -n -f -oStrictHostKeyChecking=no node$i "docker swarm leave --force"
sleep 10
    sudo ssh -n -f -oStrictHostKeyChecking=no node$i "$command"
sleep 10

done

sudo ssh -n -f -oStrictHostKeyChecking=no node1 "docker network create --attachable --driver overlay first-network"
 


