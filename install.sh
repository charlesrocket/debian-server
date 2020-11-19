#!/bin/bash
cat << "EOF"

▓█████▄  ██▓  ██████  ▄████▄   ▒█████
▒██▀ ██▌▓██▒▒██    ▒ ▒██▀ ▀█  ▒██▒  ██▒
░██   █▌▒██▒░ ▓██▄   ▒▓█    ▄ ▒██░  ██▒
░▓█▄   ▌░██░  ▒   ██▒▒▓▓▄ ▄██▒▒██   ██░
░▒████▓ ░██░▒██████▒▒▒ ▓███▀ ░░ ████▓▒░
 ▒▒▓  ▒ ░▓  ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒░▒░▒░
 ░ ▒  ▒  ▒ ░░ ░▒  ░ ░  ░  ▒     ░ ▒ ▒░
 ░ ░  ░  ▒ ░░  ░  ░  ░        ░ ░ ░ ▒
   ░     ░        ░  ░ ░          ░ ░
 ░                   ░

EOF
echo "Installing Ansible..."
sudo apt update
sudo apt install python python3-distutils ansible -y
echo ""
echo "Done"
echo ""
echo "Enter 'ansible-playbook debian.yml --ask-become-pass' to start"
