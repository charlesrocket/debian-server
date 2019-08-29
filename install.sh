#!/bin/bash

echo "Adding Ansible PPA"
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible

echo "Installing Ansible..."
sudo apt-get update
sudo apt-get install ansible -y
echo "DONE"
