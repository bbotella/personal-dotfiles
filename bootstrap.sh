#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
LOG_FILE="$HOME/.dotfiles-install.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}✅ $1${NC}" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}❌ $1${NC}" | tee -a "$LOG_FILE"
}

print_banner() {
    echo -e "${BLUE}"
    cat << "EOF"
      _       _      __ _ _            
   __| | ___ | |_   / _(_) | ___  ___  
  / _` |/ _ \| __| | |_| | |/ _ \/ __| 
 | (_| | (_) | |_  |  _| | |  __/\__ \ 
  \__,_|\___/ \__| |_| |_|_|\___||___/ 
                                      
 🚀 Bootstrap Script v2.0
EOF
    echo -e "${NC}"
}

check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        error "This script is designed for macOS only"
        exit 1
    fi
    success "macOS detected"
}

install_xcode_tools() {
    info "Checking for Xcode Command Line Tools..."
    if xcode-select -p &> /dev/null; then
        success "Xcode Command Line Tools already installed"
    else
        info "Installing Xcode Command Line Tools..."
        xcode-select --install
        warning "Please complete the Xcode Command Line Tools installation and run this script again"
        exit 1
    fi
}

install_homebrew() {
    info "Checking for Homebrew..."
    if command -v brew &> /dev/null; then
        success "Homebrew already installed"
        info "Updating Homebrew..."
        brew update
    else
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        success "Homebrew installed successfully"
    fi
}

install_git() {
    info "Checking for Git..."
    if command -v git &> /dev/null; then
        success "Git already installed"
    else
        info "Installing Git via Homebrew..."
        brew install git
        success "Git installed successfully"
    fi
}

setup_dotfiles_repo() {
    local dotfiles_dir="$HOME/personal-dotfiles"
    
    if [[ -d "$dotfiles_dir" ]]; then
        info "Dotfiles directory already exists"
        cd "$dotfiles_dir"
        if git rev-parse --git-dir > /dev/null 2>&1; then
            info "Pulling latest changes..."
            git pull origin main || git pull origin master
            success "Dotfiles updated"
        else
            warning "Directory exists but is not a git repository"
        fi
    else
        info "Cloning dotfiles repository..."
        git clone https://github.com/yourusername/personal-dotfiles.git "$dotfiles_dir"
        cd "$dotfiles_dir"
        success "Dotfiles repository cloned"
    fi
}

install_essential_tools() {
    info "Installing essential tools..."
    
    # Install GNU Stow if not present
    if ! command -v stow &> /dev/null; then
        info "Installing GNU Stow..."
        brew install stow
        success "GNU Stow installed"
    else
        success "GNU Stow already installed"
    fi
    
    # Install antidote if not present
    if ! brew list antidote &> /dev/null; then
        info "Installing antidote..."
        brew install antidote
        success "Antidote installed"
    else
        success "Antidote already installed"
    fi
}

setup_shell() {
    info "Setting up shell..."
    
    # Check if zsh is the default shell
    if [[ "$SHELL" != */zsh ]]; then
        info "Changing default shell to zsh..."
        chsh -s /bin/zsh
        success "Default shell changed to zsh"
        warning "Please restart your terminal session"
    else
        success "Zsh is already the default shell"
    fi
}

create_directories() {
    info "Creating necessary directories..."
    
    # Create directories that might be needed
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    
    success "Directories created"
}

main() {
    print_banner
    log "Starting dotfiles bootstrap process"
    
    check_os
    install_xcode_tools
    install_homebrew
    install_git
    setup_dotfiles_repo
    install_essential_tools
    create_directories
    setup_shell
    
    success "Bootstrap process completed!"
    info "Next steps:"
    echo "  1. Run './install.sh' to symlink your dotfiles"
    echo "  2. Run 'brew bundle install' to install all packages"
    echo "  3. Restart your terminal or run 'source ~/.zshrc'"
    
    log "Bootstrap process completed successfully"
}

# Run main function
main "$@"