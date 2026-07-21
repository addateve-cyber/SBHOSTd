#!/bin/bash

# =====================================================
# SBHOST Minecraft VPS Installer
# Version 1.0
# =====================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Please run this installer as ROOT.${NC}"
    exit 1
fi

clear

echo -e "${CYAN}"

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

echo -e "${NC}"

sleep 2
# ==========================================
# Loading Animation
# ==========================================

loading_bar() {
    local TEXT="$1"

    echo -ne "${YELLOW}${TEXT} ${NC}[          ]"

    for i in {1..10}; do
        sleep 0.15
        echo -ne "\r${YELLOW}${TEXT} ${NC}["
        for ((j=1;j<=i;j++)); do
            echo -n "="
        done
        for ((j=i;j<10;j++)); do
            echo -n " "
        done
        echo -n "]"
    done

    echo -e " ${GREEN}DONE!${NC}"
}

loading_bar "Checking System"
loading_bar "Loading Modules"
loading_bar "Preparing Installer"

# ==========================================
# Main Menu
# ==========================================

main_menu() {

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
echo "===================================="
echo "        SBHOST MAIN MENU"
echo "===================================="
echo
echo " [1] Create Minecraft VPS"
echo " [2] Restart VPS"
echo " [3] Delete VPS"
echo " [4] Exit"
echo

read -p "Select Option: " OPTION

case "$OPTION" in
1)create_vps() {

clear

echo "======================================"
echo "      SBHOST VPS Configuration"
echo "======================================"
echo

read -p "Enter Email: " EMAIL
read -p "Enter Username: " USERNAME
read -s -p "Enter Password: " PASSWORD
echo
echo

read -p "RAM (GB): " RAM
read -p "CPU Cores: " CPU
read -p "Disk Size (GB): " DISK

echo
echo "======================================"
echo "Configuration"
echo "======================================"

echo "Email      : $EMAIL"
echo "Username   : $USERNAME"
echo "RAM         : ${RAM}GB"
echo "CPU Cores   : $CPU"
echo "Disk        : ${DISK}GB"

echo
read -p "Continue Installation? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    main_menu
fi

echo
echo "Installing Packages..."

apt update -y
apt upgrade -y

apt install -y \
curl \
wget \
git \
screen \
unzip \
fastfetch \
qemu-system-x86 \
qemu-utils \
cloud-image-utils

echo
echo "Packages Installed Successfully."

sleep 2

}
;;

2)
echo "Restart VPS Selected"
;;

3)
echo "Delete VPS Selected"
;;

4)
exit 0
;;

*)
echo "Invalid Option!"
sleep 2
main_menu
;;
esac

}

main_menu
