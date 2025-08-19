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
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

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
  / _\` |/ _ \| __| | |_| | |/ _ \/ __| 
 | (_| | (_) | |_  |  _| | |  __/\__ \ 
  \__,_|\___/ \__| |_| |_|_|\___||___/ 
                                      
 🔗 Dotfiles Installer v2.0
EOF
    echo -e "${NC}"
}

check_dependencies() {
    info "Checking dependencies..."
    
    if ! command -v stow &> /dev/null; then
        error "GNU Stow is not installed. Please run bootstrap.sh first."
        exit 1
    fi
    
    if ! command -v brew &> /dev/null; then
        warning "Homebrew not found. Some features may not work."
    fi
    
    success "Dependencies check completed"
}

backup_existing_configs() {
    info "Creating backup of existing configurations..."
    mkdir -p "$BACKUP_DIR"
    
    # List of common config files/dirs to backup
    local configs=(
        ".zshrc" ".zshenv" ".aliases.sh" ".exports.sh"
        ".tmux.conf" ".vimrc" ".gitconfig"
        ".config/zellij" ".config/nvim"
    )
    
    local backed_up=0
    for config in "${configs[@]}"; do
        if [[ -e "$HOME/$config" ]] && [[ ! -L "$HOME/$config" ]]; then
            cp -r "$HOME/$config" "$BACKUP_DIR/"
            info "Backed up: $config"
            backed_up=$((backed_up + 1))
        fi
    done
    
    if [[ $backed_up -gt 0 ]]; then
        success "Backed up $backed_up configurations to $BACKUP_DIR"
    else
        info "No existing configurations found to backup"
        rmdir "$BACKUP_DIR" 2>/dev/null || true
    fi
}

install_homebrew_packages() {
    if command -v brew &> /dev/null; then
        info "Checking Homebrew packages..."
        if [[ -f "$DOTFILES/brew/Brewfile" ]]; then
            cd "$DOTFILES"
            if brew bundle check --file=brew/Brewfile &> /dev/null; then
                success "All Homebrew packages are already installed"
            else
                info "Installing missing Homebrew packages..."
                brew bundle install --file=brew/Brewfile
                success "Homebrew packages installed"
            fi
        else
            warning "Brewfile not found, skipping Homebrew package installation"
        fi
    else
        warning "Homebrew not installed, skipping package installation"
    fi
}

print_banner
log "Starting dotfiles installation process"
cd ~
DOTFILES=~/personal-dotfiles

# Verify dotfiles directory exists
if [[ ! -d "$DOTFILES" ]]; then
    error "Dotfiles directory not found at $DOTFILES"
    error "Please run bootstrap.sh first to set up the repository"
    exit 1
fi

cd "$DOTFILES"

check_dependencies
backup_existing_configs
install_homebrew_packages

info "Linking dotfiles configurations..."

# Get list of directories, excluding certain ones
packages=()
for dir in */; do
    dir_name="${dir%/}"
    case "$dir_name" in
        .git|scripts|docs|README*|LICENSE*|*.md)
            continue
            ;;
        *)
            packages+=("$dir_name")
            ;;
    esac
done

if [[ ${#packages[@]} -eq 0 ]]; then
    warning "No dotfile packages found to install"
    exit 0
fi

info "Found ${#packages[@]} packages to install: ${packages[*]}"

# Install packages with stow
failed_packages=()
for package in "${packages[@]}"; do
    info "Installing package: $package"
    if stow -R "$package" 2>/dev/null; then
        success "Linked $package"
    else
        error "Failed to link $package"
        failed_packages+=("$package")
    fi
done

# Report results
if [[ ${#failed_packages[@]} -eq 0 ]]; then
    success "All dotfiles linked successfully!"
else
    warning "Failed to link ${#failed_packages[@]} packages: ${failed_packages[*]}"
    warning "Check for conflicts or missing dependencies"
fi

# Post-installation steps
info "Post-installation steps:"
echo "  1. Restart your terminal or run 'source ~/.zshrc'"
echo "  2. Run 'p10k configure' to set up Powerlevel10k theme"
echo "  3. Check '$LOG_FILE' for detailed logs"

if [[ -d "$BACKUP_DIR" ]]; then
    echo "  4. Your old configs are backed up in '$BACKUP_DIR'"
fi

success "Dotfiles installation completed!"
log "Dotfiles installation process completed"