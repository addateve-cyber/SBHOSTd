#!/bin/bash

set -e

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

clear

echo -e "$CYAN"

cat << "EOF"

 ███████╗██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
 ██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
 ███████╗██████╔╝███████║██║   ██║███████╗   ██║
 ╚════██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║
 ███████║██████╔╝██║  ██║╚██████╔╝███████║   ██║
 ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝

        SBHOST Minecraft Installer
               Version 1.0

EOF

echo -e "$RESET"

sleep 2

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this installer as root.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Updating system...${RESET}"
apt update -y
apt upgrade -y

echo -e "${YELLOW}Installing Java...${RESET}"
apt install -y openjdk-21-jre-headless curl wget screen unzip

mkdir -p /opt/minecraft

echo -e "${GREEN}System ready!${RESET}"
# ===============================
# SBHOST Loading Animation
# ===============================

loading() {
    TEXT=$1

    echo
    echo -e "${CYAN}$TEXT${RESET}"

    for i in {1..30}; do
        printf "█"
        sleep 0.05
    done

    echo
    echo
}

loading "Initializing SBHOST..."
loading "Checking Dependencies..."
loading "Loading Dashboard..."

main_menu(){

clear

echo -e "${GREEN}"

cat << "EOF"

███████╗██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
███████╗██████╔╝███████║██║   ██║███████╗   ██║
╚════██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║
███████║██████╔╝██║  ██║╚██████╔╝███████║   ██║
╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝

EOF

echo

echo "=========================================="
echo "      SBHOST Minecraft Dashboard"
echo "=========================================="

echo

echo "[1] Create Minecraft Server"
echo "[2] Install Java"
echo "[3] Server Information"
echo "[4] Exit"

echo

read -p "Select Option: " OPTION

case $OPTION in

1)

echo "Create Minecraft Server"

;;

2)

echo "Java Already Installed"

;;

3)

echo

echo "OS Information"

cat /etc/os-release | grep PRETTY_NAME

echo

echo "RAM"

free -h

echo

echo "CPU"

nproc

;;

4)

exit

;;

*)

echo "Invalid Option"

sleep 2

main_menu

;;

esac

}

main_menu
