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
# ==========================================
# Loading Animation
# ==========================================

loading_bar() {
    local msg="$1"

    echo -ne "${YELLOW}$msg ${NC}[          ]"

    for i in 1 2 3 4 5 6 7 8 9 10
    do
        sleep 0.2
        echo -ne "\r${YELLOW}$msg ${NC}["
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

loading_bar "Initializing SBHOST..."
loading_bar "Checking System..."
loading_bar "Loading Modules..."

# ==========================================
# Main Menu
# ==========================================

show_menu() {

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
echo "============== SBHOST MENU =============="
echo
echo " [1] Create Minecraft VPS"
echo " [2] Restart VPS"
echo " [3] Settings"
echo " [4] Exit"
echo

read -p "Select Option: " OPTION

case $OPTION in

1)
echo "Create VPS Selected"
;;

2)
echo "Restart Selected"
;;

3)
echo "Settings Selected"
;;

4)
exit
;;

*)
echo "Invalid Option"
sleep 2
show_menu
;;

esac

}

show_menu
