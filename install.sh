#!/bin/bash

echo "Adding Ansible PPA"
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y

echo "Installing Ansible..."
sudo apt-get update
sudo apt-get install ansible -y
echo "DONE"
