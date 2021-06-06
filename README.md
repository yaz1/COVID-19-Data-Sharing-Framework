# COVID-19-Data-Sharing-Framework

# Deployment Steps: 

1- Prepare the five nodes by running the script init.sh 5 [ path to env0.sh file]. Note that it is assumed that the nodes are accessible with Root privileges via ssh node[sequence number starting from 0]. For example, the first node is accessible via ssh node0 and the second node via ssh node2.

2- The initialization script copies all necessary code files under /mydata

3- Navigate to "/mydata/fabric/fabric-samples/5host-deployment" and run the crypto.sh script

4- The script generates two folders: crypto-config and channel-artifacts.

5- Copy the two folders to the five nodes in the directory "/mydata/fabric/fabric-samples/5host-deployment"

6- Create a Docker swarm by running the script ./swarm.sh 5. The script file can be found under the 5host-deployment folder.

7- Run the Hyperledger components by executing the script ./runhosts.sh 5 up

8- Create a channel by running the script ./mychannelup.sh

9- Create and deploy the contract for sharing public data by running the script ./deploy-contract.sh

10- Create and deploy the contract for sharing private data by running the script ./deploy-contract-private.sh

11- The Test.sh file contains some teset commands for sharing public data and sending private data collection

Acknowledgement
Parts of the code are adopted from: https://kctheservant.medium.com/multi-host-deployment-for-first-network-hyperledger-fabric-v2-273b794ff3d

Note: Used Ubuntu 20.04, m510 nodes of Cloudlab
