#!/bin/bash

# ===========================
# SBHOST Functions Library
# ===========================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

print_line() {
    echo -e "${CYAN}============================================================${NC}"
}

pause() {
    echo
    read -p "Press ENTER to continue..."
}

loading() {
    local TEXT="$1"

    echo -ne "${YELLOW}${TEXT}${NC} "

    for i in {1..20}; do
        echo -n "█"
        sleep 0.05
    done

    echo -e " ${GREEN}DONE${NC}"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}Please run this installer as root.${NC}"
        exit 1
    fi
}

install_packages() {
    loading "Updating package lists"
    apt update -y

    loading "Upgrading packages"
    apt upgrade -y

    loading "Installing dependencies"

    apt install -y \
        curl \
        wget \
        git \
        unzip \
        screen \
        fastfetch \
        qemu-system-x86 \
        qemu-utils \
        cloud-image-utils
}
