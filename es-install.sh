#!/bin/bash
cd ~

# Config
ES_VERSION="elasticsearch-1.0.0.noarch.rpm"
AWS_PLUGIN_VERSION="2.0.0.RC1"

# Install ES
echo "Installing Elasticsearch"
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_VERSION
sudo rpm -ivh elasticsearch-1.0.0.RC2.noarch.rpm
echo "Elasticsearch Installed"

# Install plugins (AWS and Marvel)
sudo /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-cloud-aws/$AWS_PLUGIN_VERSION
sudo /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# If a custom config file exists
if [ -f ./elasticsearch.yaml ]
  then
  	echo "Adding our custom config"
    sudo rm /etc/elasticsearch/elasticsearch.yml
    sudo cp ./elasticsearch.yaml /etc/elasticsearch/elasticsearch.yml
fi

echo "Cleaning up..."
rm $ES_VERSION