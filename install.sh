#!/bin/bash

echo "Updating OS"
sudo apt update
sudo apt upgrade -y

echo "Adding Ansible PPA"
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible

echo "Installing Ansible..."
sudo apt install ansible -y
echo "DONE"
