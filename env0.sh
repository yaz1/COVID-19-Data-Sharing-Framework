#!/bin/bash
sudo apt-get update
sudo apt --yes install software-properties-common
sudo add-apt-repository --yes ppa:deadsnakes/ppa
sudo apt install -y python3-pip
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt-get --yes install python-tk
#sudo apt-get --yes install iperf
sudo apt-get --yes install screen
sudo apt-get --yes install htop
sudo apt-get --yes install maven
sudo apt install --yes default-jdk
sudo apt-get install -y sysstat
sudo apt-get install -y curl
sudo apt install docker --yes
sudo apt install docker.io --yes
sudo apt install docker-compose --yes
sudo apt install nodejs --yes
sudo apt install npm --yes
sudo npm install npm@5.6.0 -g



sudo mkdir -p /mydata/fabric
cd /mydata
wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
sudo tar -xvf go1.16.2.linux-amd64.tar.gz
#sudo chown -R root:root /mydata/
echo "export GOROOT=/mydata/go" >>~/.bashrc
echo "export GOPATH=/mydata/fabric/fabric-samples" >>~/.bashrc
echo "export PATH=/mydata/fabric/fabric-samples/bin:/mydata/go/bin:$PATH" >>~/.bashrc
source ~/.profile
cd fabric
curl -sSL https://bit.ly/2ysbOFE | bash -s

shared="/proj/bc-PG0/scripts"
cp -r $shared/"5host-deployment" /mydata/fabric/fabric-samples
cp -r $shared/"5host-deployment"/"go" /mydata/fabric/fabric-samples/chaincode
cp -r $shared/"5host-deployment"/"go-private" /mydata/fabric/fabric-samples/chaincode
#sudo env "PATH=$PATH" go

