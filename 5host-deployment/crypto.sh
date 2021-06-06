#!/bin/bash
mkdir crypto-config
mkdir channel-artifacts

rm -rf ./crypto-config/*
rm -rf ./channel-artifacts/*


cryptogen generate --config=crypto-config.yaml --output=crypto-config


../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block -channelID system-channel

../bin/configtxgen -profile MultiOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

../bin/configtxgen -profile MultiOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

../bin/configtxgen -profile MultiOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP

../bin/configtxgen -profile MultiOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID mychannel -asOrg Org3MSP

../bin/configtxgen -profile MultiOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID mychannel -asOrg Org4MSP

../bin/configtxgen -profile MultiOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org5MSPanchors.tx -channelID mychannel -asOrg Org5MSP

