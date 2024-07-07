#!/bin/bash

sudo apt -y update
sudo apt -y install git
cd /opt
git clone https://github.com/EvgeniyGushchin/shvirtd-example-python.git
cd /opt/shvirtd-example-python/
docker compose up -d