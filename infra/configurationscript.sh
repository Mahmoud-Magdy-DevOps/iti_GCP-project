#!/bin/bash
date > /tmp/time.txt

#install gcloud
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates gnupg curl software-properties-common  -y

echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.asc
sudo apt-get update && sudo apt-get install google-cloud-cli -y

apt install python3-pip -y

#install Docker environment: dependences already installed.

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce > /tmp/docker.txt

sudo apt install docker-ce -y
date >> /tmp/time.txt
#sudo apt-get install google-cloud -y
#sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
#sudo apt-get install kubectl -y