#!/bin/bash

clear

echo -e "\e[1;36m"
cat << "EOF"

███████╗██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
███████╗██████╔╝███████║██║   ██║███████╗   ██║
╚════██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║
███████║██████╔╝██║  ██║╚██████╔╝███████║   ██║
╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝

        SBHOST Minecraft VPS Installer
              Version 1.0

EOF
echo -e "\e[0m"

sleep 2

echo "======================================="
echo "      Create a Minecraft VPS"
echo "======================================="

read -p "Enter Email: " EMAIL
read -p "Enter Username: " USERNAME
read -s -p "Enter Password: " PASSWORD
echo

echo "Updating system..."
apt update -y
apt upgrade -y

echo "Installing required packages..."
apt install -y curl wget git screen unzip fastfetch openjdk-21-jre

echo "Packages installed successfully!"
fastfetch
