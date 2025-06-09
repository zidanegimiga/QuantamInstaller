#!/bin/bash

# This script will install Miniconda and git with all dependencies for this 
# project. This enables a user to install this project without manually 
# installing Conda and git.

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color
BLINK='\033[5m'

clear

typewriter() {
    text="$1"
    delay="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo
}

glitch_text() {
    local text="$1"
    local colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$MAGENTA" "$CYAN")
    
    for i in {1..5}; do
        color=${colors[$((RANDOM % 6))]}
        echo -en "\r${color}${text}${NC}"
        sleep 0.1
    done
    echo -e "\r${WHITE}${text}${NC}"
}

loading_bar() {
    local duration=$1
    local width=50
    local fill="█"
    local empty="░"
    
    for ((i=0; i<=width; i++)); do
        local percent=$((i * 100 / width))
        local filled=$(printf "%*s" $i | tr ' ' "$fill")
        local unfilled=$(printf "%*s" $((width - i)) | tr ' ' "$empty")
        
        printf "\r${CYAN}[${filled}${unfilled}] ${percent}%%${NC}"
        sleep $(echo "scale=3; $duration / $width" | bc -l 2>/dev/null || echo "0.05")
    done
    echo
}

matrix_logo() {
    echo -e "${GREEN}"
    echo "    ╔══════════════════════════════════════════════════════════════╗"
    echo "    ║  ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗████████╗██╗   ██╗███╗   ███╗ ║"
    echo "    ║ ██╔═══██╗██║   ██║██╔══██╗████╗  ██║╚══██╔══╝██║   ██║████╗ ████║ ║"
    echo "    ║ ██║   ██║██║   ██║███████║██╔██╗ ██║   ██║   ██║   ██║██╔████╔██║ ║"
    echo "    ║ ██║▄▄ ██║██║   ██║██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╔╝██║ ║"
    echo "    ║ ╚██████╔╝╚██████╔╝██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚═╝ ██║ ║"
    echo "    ║  ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝ ║"
    echo "    ║                                                                  ║"
    echo "    ║    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗  ║"
    echo "    ║    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗ ║"
    echo "    ║    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝ ║"
    echo "    ║    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗ ║"
    echo "    ║    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║ ║"
    echo "    ║    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝ ║"
    echo "    ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

cyber_banner() {
    echo -e "${MAGENTA}${BOLD}"
    echo "    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
    echo "    █                                                                █"
    echo "    █  ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▄░░▒▓██████▄░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒  █"
    echo "    █      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒  █"
    echo "    █          ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒      █"
    echo "    █      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒║▒▓█▓▒░░▒▓█▓▒          █"
    echo "    █  ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░▒▓██████▓▒░▒▓████████▓▒░▒▓█▓▒║░▒▓█▓▒  █"
    echo "    █                                                                █"
    echo "    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
    echo -e "${NC}"
}

echo -e "${BOLD}${CYAN}Initializing Quantum Installer...${NC}"
sleep 1

glitch_text "QUANTUM_INSTALLER_V9.5_LOADING..."
sleep 0.5

echo -e "\n${YELLOW}Loading installation matrix...${NC}"
loading_bar 2

clear
matrix_logo

echo -e "\n${BLINK}${RED}>>> QUANTUM INSTALLER V9.5 <<<${NC}"
sleep 0.5

cyber_banner

echo -e "\n${CYAN}${BOLD}System Administrator:${NC}"
typewriter "Zidane Gimiga - Quantum Installer Architect" 0.05

echo -e "\n${GREEN}${BOLD}Mission Briefing:${NC}"
typewriter "Installing Miniconda and Git dependencies..." 0.03
typewriter "Preparing quantum development environment..." 0.03
typewriter "Establishing secure connection to repositories..." 0.03

echo -e "\n${YELLOW}Status Indicators:${NC}"
echo -e "${GREEN}[✓]${NC} Quantum protocols activated"
echo -e "${GREEN}[✓]${NC} Neural networks synchronized"
echo -e "${GREEN}[✓]${NC} Installation matrix loaded"
echo -e "${CYAN}[→]${NC} Ready to commence installation"

echo -e "\n${BOLD}${WHITE}Press ENTER to initiate quantum installation sequence...${NC}"
read -r

echo -e "\n${GREEN}${BOLD}🚀 QUANTUM INSTALLATION COMMENCING... 🚀${NC}\n"