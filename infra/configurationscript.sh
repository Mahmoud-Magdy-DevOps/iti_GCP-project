#!/bin/bash
echo "start script">> /log.txt
date >> /log.txt

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
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock

echo "all installed" >> /log.txt

# Clone app and reate a Dockerfile 
echo "Clone app and create a Dockerfile" >> /log.txt
cd /home/mahmoud

git clone https://github.com/Hendawyy/simple-node-app
cd simple-node-app

# Create a Dockerfile
cdf=$(cat <<EOL

FROM node:18 AS build

# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy app code into the container
COPY . .

FROM gcr.io/distroless/nodejs:18

COPY --from=build /app /app

WORKDIR /app

# Expose the port The app runs on
EXPOSE 5000

# Start the Node.js app
CMD ["index.js"]

EOL
)

echo "$cdf" > Dockerfile

sudo docker build -t node-app:v1 .
echo "image build done" >> /log.txt
echo "all done" >> /log.txt
date >> /log.txt

sudo apt-get install kubectl
echo "kubectl installed" >> /log.txt
#sudo apt-get install google-cloud -y
#sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
#sudo apt-get install kubectl -y