#!/bin/bash

# Exit immediately if any command fails
set -e

# Colors
RED="\033[31m\033[1m"
GREEN="\033[92m"
YELLOW="\033[33m"
RESET="\033[0m"

# Trap Ctrl+C
trap 'echo -e "${RED}OOPS! Failed${RESET}"; exit 1' SIGINT

# Function: Print Banner
print_banner() {
    if command -v figlet >/dev/null 2>&1; then
        echo -e "${GREEN}$(figlet -f slant "$1")${RESET}"
    else
        echo -e "${YELLOW}[INFO] figlet not found. Installing...${RESET}"
        sudo apt install figlet -y
        echo -e "${GREEN}$(figlet -f slant "$1")${RESET}"
    fi
}

# Function: Step Handler
run_step() {
    echo -e "${YELLOW}➡ $1...${RESET}"
    eval "$2"
    echo -e "${GREEN}✔ Done${RESET}\n"
}

# Ask for sudo access
echo -e "${YELLOW}🔐 Requesting sudo access...${RESET}"
sudo -v

# Keep sudo alive (background refresh)
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!

# Start Process
print_banner "Updating System"

run_step "Updating package lists" "sudo apt update -y"
run_step "Upgrading system" "sudo apt full-upgrade -y"

print_banner "Cleaning Up"

run_step "Removing unused packages" "sudo apt autoremove -y"
run_step "Cleaning cache" "sudo apt autoclean -y"

# Stop sudo keep-alive
kill $SUDO_PID

print_banner "All Set!"

echo -e "${GREEN}System successfully updated and cleaned.${RESET}"
