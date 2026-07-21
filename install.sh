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

create_minecraft_server() {

clear

echo "=========================================="
echo "     SBHOST Minecraft Setup Wizard"
echo "=========================================="
echo

read -p "Server Name: " SERVER_NAME
read -p "Owner Email: " EMAIL
read -p "Admin Username: " USERNAME
read -s -p "Admin Password: " PASSWORD
echo
echo

read -p "Minecraft Version (example: 1.21.8): " MC_VERSION
read -p "RAM (GB): " RAM_GB
read -p "Server Port [25565]: " PORT

PORT=${PORT:-25565}

echo
echo "=========================================="
echo "Configuration Summary"
echo "=========================================="

echo "Server Name : $SERVER_NAME"
echo "Email       : $EMAIL"
echo "Username    : $USERNAME"
echo "Version     : $MC_VERSION"
echo "RAM         : ${RAM_GB}GB"
echo "Port        : $PORT"

echo
read -p "Continue? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    main_menu
fi

echo
echo "Creating folders..."

mkdir -p /opt/minecraft
cd /opt/minecraft

echo "eula=true" > eula.txt

cat > server.properties <<EOF
motd=$SERVER_NAME
server-port=$PORT
online-mode=true
max-players=20
view-distance=10
simulation-distance=10
EOF

echo
echo "Minecraft directory created successfully!"
echo
echo "Next step: Downloading Minecraft server..."
sleep 3

}

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
