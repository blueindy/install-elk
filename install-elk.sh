#!/bin/bash

# Install Java
echo "Installing Java..."
sudo apt update
sudo apt install openjdk-8-jdk -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Java"
  exit 1
fi

# Install Elasticsearch
echo "Installing Elasticsearch..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install elasticsearch -y
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Elasticsearch"
  exit 1
fi

# Install Logstash
echo "Installing Logstash..."
sudo apt install logstash -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Logstash"
  exit 1
fi

# Install Kibana
echo "Installing Kibana..."
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install kibana -y
sudo systemctl enable kibana
sudo systemctl start kibana
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Kibana"
  exit 1
fi

echo "ELK stack installation completed successfully"
