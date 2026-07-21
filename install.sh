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
case $OPTION in


1)
    create_minecraft_server
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
create_minecraft_server() {

clear

echo "========================================"
echo "      SBHOST Minecraft Setup Wizard"
echo "========================================"
echo

read -p "Server Name: " SERVER_NAME
read -p "Minecraft Version (Example: 1.21.8): " MC_VERSION
read -p "RAM (GB): " RAM_GB
read -p "Server Port [25565]: " PORT

PORT=${PORT:-25565}

echo
echo "Creating Minecraft Server..."

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
echo "Downloading Purpur..."

wget -O server.jar "https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download"

if [ ! -f server.jar ]; then
    echo
    echo "ERROR: Failed to download Minecraft server."
    read -p "Press Enter..."
    main_menu
    return
fi

cat > start.sh <<EOF
#!/bin/bash
java -Xms${RAM_GB}G -Xmx${RAM_GB}G -jar server.jar nogui
EOF

chmod +x start.sh

echo
echo "========================================"
echo "Minecraft Server Installed!"
echo "========================================"
echo
echo "Folder : /opt/minecraft"
echo "Start  : ./start.sh"
echo

read -p "Start Server Now? (y/n): " START

if [[ "$START" == "y" || "$START" == "Y" ]]; then
    ./start.sh
fi

read -p "Press Enter to return menu..."
main_menu

}
main_menu
