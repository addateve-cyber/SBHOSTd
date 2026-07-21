#!/bin/bash

set -e

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

clear

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

sleep 2

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Updating system...${RESET}"
apt update -y
apt install -y curl wget screen unzip openjdk-21-jre-headless

echo -e "${GREEN}Dependencies Installed Successfully.${RESET}"
sleep 1
loading() {
    local TEXT="$1"

    echo
    echo -e "${CYAN}${TEXT}${RESET}"

    for i in {1..30}; do
        printf "█"
        sleep 0.03
    done

    echo
    echo
}

loading "Initializing SBHOST..."
loading "Checking Dependencies..."
loading "Loading Dashboard..."

main_menu() {

while true; do

clear

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
echo "        SBHOST Dashboard"
echo "=========================================="
echo
echo " [1] Create Minecraft Server"
echo " [2] Install Java"
echo " [3] Server Information"
echo " [4] Exit"
echo

read -p "Select Option: " OPTION

case "$OPTION" in

1)
    echo "Create Minecraft Server - Coming in Step 3"
    read -p "Press Enter..."
    ;;

2)
    echo "Java is already installed."
    read -p "Press Enter..."
    ;;

3)
    echo
    grep PRETTY_NAME /etc/os-release
    echo
    free -h
    echo
    nproc
    echo
    read -p "Press Enter..."
    ;;

4)
    exit 0
    ;;

*)
    echo "Invalid Option."
    sleep 2
    ;;

esac

done

}

main_menu
