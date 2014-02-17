#!/bin/bash
cd ~

# Config
ES_FILENAME="elasticsearch-1.0.0.noarch.rpm"
AWS_PLUGIN_VERSION="2.0.0.RC1"

# Install ES
echo "Installing Elasticsearch"
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_FILENAME
sudo rpm -ivh $ES_FILENAME
echo "Elasticsearch Installed"

# Install plugins (AWS and Marvel)
sudo /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-cloud-aws/$AWS_PLUGIN_VERSION
sudo /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# If a custom config file exists
if [ -f /home/ec2-user/elasticsearch.yml ]
  then
  	echo "Removing the default config"
    sudo rm /etc/elasticsearch/elasticsearch.yml
    echo "Adding our custom config"
    sudo cp /home/ec2-user/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
fi

echo "Cleaning up ES install resources..."
rm $ES_FILENAME