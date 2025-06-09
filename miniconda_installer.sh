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


set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly PACKAGES_TO_INSTALL="python=3.11 git pip"
readonly REPO_URL="https://github.com/ParisNeo/lollms-webui.git"
readonly ENV_NAME="lollms"
readonly ARCH=$(uname -m)

readonly INSTALLER_FILES="$SCRIPT_DIR/installer_files"
readonly MINICONDA_DIR="$INSTALLER_FILES/miniconda3"
readonly INSTALL_ENV_DIR="$INSTALLER_FILES/lollms_env"
readonly LOLLMS_DIR="$SCRIPT_DIR/lollms-webui"

readonly MINICONDA_URL=$(
  [[ "$ARCH" == "arm64" ]] && 
  echo "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh" ||
  echo "https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
)

log() { echo ">>> $*"; }
error_exit() { echo "ERROR: $*" >&2; exit 1; }


print_banner() {
  cat << 'EOF'
*****************************************************
***            LoLLMs Installation Script        ***
***         Large Language Models WebUI          ***
*****************************************************
EOF
}


preflight_checks() {
  log "Running pre-flight checks..."
  
  [[ "$SCRIPT_DIR" == *" "* ]] && error_exit "Installation path contains spaces. Miniconda cannot be installed."
  
  if [[ "$SCRIPT_DIR" =~ [^a-zA-Z0-9/_.-] ]]; then
    echo "WARNING: Special characters detected in path. This may cause installation issues."
    read -rp "Press Enter to continue or Ctrl+C to abort..."
  fi
  
  ((${#SCRIPT_DIR} > 100)) && echo "WARNING: Long installation path detected. This may cause issues."
}


setup_homebrew() {
  log "Checking Homebrew installation..."
  
  if ! command -v brew &>/dev/null; then
    error_exit "Homebrew is required. Install from https://brew.sh"
  fi
  
  log "Homebrew found. Checking GCC..."
  
  if brew list gcc &>/dev/null; then
    log "GCC already installed"
  else
    log "Installing GCC..."
    brew install gcc
  fi
}

setup_environment() {
  log "Setting up clean environment..."
  unset CONDA_SHLVL PYTHONPATH PYTHONHOME
  export PYTHONNOUSERSITE=1
  export TEMP="$INSTALLER_FILES/temp"
  export TMP="$INSTALLER_FILES/temp"
  
  mkdir -p "$INSTALLER_FILES/temp"
}


install_miniconda() {
  [[ -f "$MINICONDA_DIR/bin/activate" ]] && { log "Miniconda already installed"; return; }
  
  log "Installing Miniconda..."
  
  local installer_name
  [[ "$ARCH" == "arm64" ]] && installer_name="Miniforge3-MacOSX-arm64.sh" || installer_name="Miniconda3-latest-MacOSX-x86_64.sh"

  curl -fsSL "$MINICONDA_URL" -o "$installer_name"
  bash "$installer_name" -b -p "$MINICONDA_DIR" || error_exit "Miniconda installation failed"
  rm -f "$installer_name"
  
  [[ -f "$MINICONDA_DIR/bin/activate" ]] || error_exit "Miniconda installation verification failed"
}


setup_conda_env() {
  log "Setting up conda environment..."
  source "$MINICONDA_DIR/bin/activate" || error_exit "Failed to activate Miniconda"
  if [[ ! -d "$INSTALL_ENV_DIR" ]]; then
    log "Creating conda environment with: $PACKAGES_TO_INSTALL"
    conda create -y -n "$ENV_NAME" $PACKAGES_TO_INSTALL || error_exit "Conda environment creation failed"
  fi
  conda activate "$ENV_NAME" || error_exit "Environment activation failed"
  
  conda install conda -y
  
  log "Environment '$ENV_NAME' activated"
  export CUDA_PATH="$INSTALL_ENV_DIR"
}

manage_repository() {
  log "Managing repository..."
  
  cd "$SCRIPT_DIR"
  
  if [[ -d "$LOLLMS_DIR" ]]; then
    log "Updating existing repository..."
    cd "$LOLLMS_DIR"
    git pull
    git submodule update --init --recursive
  else
    log "Cloning repository..."
    git clone --depth 1 --recurse-submodules "$REPO_URL"
    cd "$LOLLMS_DIR"
    git submodule update --init --recursive
  fi

  local components=("lollms_core" "utilities/safe_store")
  [[ ! -d "$SCRIPT_DIR/lollms-webui" ]] && components+=("utilities/pipmaster")
  
  for component in "${components[@]}"; do
    if [[ -d "$component" ]]; then
      log "Installing $component..."
      (cd "$component" && pip install -e .)
    fi
  done
}
