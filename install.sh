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
echo "Enter 'ansible-playbook ubuntu.yml --ask-become-pass' to start"
