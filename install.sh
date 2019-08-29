#!/bin/bash

echo "Adding Ansible PPA"
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes ppa:ansible/ansible

echo "Installing Ansible..."
sudo apt update
sudo apt install ansible -y
echo "DONE"
