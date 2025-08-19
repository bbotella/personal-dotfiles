# Development-specific aliases and functions
# Complements the main .aliases.sh with development workflow enhancements

# =============================================================================
# Project Navigation
# =============================================================================
alias dev="cd ~/Documents/dev"
alias xerador="cd ~/Documents/dev/data-services-control-plane"
alias dotfiles="cd ~/personal-dotfiles"

# Quick directory shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# =============================================================================
# System Information & Monitoring
# =============================================================================
alias ports="lsof -i -P -n | grep LISTEN"
alias myip="curl -s ifconfig.me && echo"
alias localip="ipconfig getifaddr en0"
alias weather="curl -s wttr.in"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# Process management
alias psg="ps aux | grep"
alias topcpu="ps aux --sort=-%cpu | head"
alias topmem="ps aux --sort=-%mem | head"

# =============================================================================
# Network & Security
# =============================================================================
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias openports="sudo lsof -i | grep LISTEN"
alias wget="wget -c"  # Resume downloads by default

# =============================================================================
# File Operations
# =============================================================================
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Safe operations
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Disk usage
alias du="du -h"
alias df="df -h"
alias ncdu="ncdu --color dark"

# =============================================================================
# Development Tools
# =============================================================================

# Docker shortcuts
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dprune="docker system prune -f"

# Kubernetes shortcuts
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deployments"
alias kaf="kubectl apply -f"
alias kdel="kubectl delete"

# Git shortcuts (complement the ones in main aliases)
alias gst="git status"
alias gaa="git add --all"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gbr="git branch"
alias gpl="git pull"
alias gps="git push"

# =============================================================================
# Java/Gradle (for your Cassandra work)
# =============================================================================
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwt="./gradlew test"
alias gwc="./gradlew clean"
alias gwcb="./gradlew clean build"
alias gwbt="./gradlew build test"

# =============================================================================
# Python Development
# =============================================================================
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"
alias req="pip install -r requirements.txt"
alias freeze="pip freeze > requirements.txt"

# =============================================================================
# Node.js Development
# =============================================================================
alias ni="npm install"
alias nis="npm install --save"
alias nid="npm install --save-dev"
alias nig="npm install --global"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"

# =============================================================================
# SSH & Remote Access
# =============================================================================
alias ssh-helper="~/personal-dotfiles/scripts/ssh-helper"
alias ssh-list="ssh-helper list"
alias ssh-test="ssh-helper test"
alias ssh-info="ssh-helper info"

# =============================================================================
# Utility Functions
# =============================================================================

# Create directory and navigate to it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Create a new project structure
mkproject() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkproject <project-name>"
        return 1
    fi
    
    mkdir -p "$1"/{src,tests,docs,scripts}
    cd "$1"
    
    # Initialize git if not already a repo
    if [[ ! -d ".git" ]]; then
        git init
        echo "# $1" > README.md
        echo -e "*.log\n*.tmp\n.DS_Store\nnode_modules/\n__pycache__/" > .gitignore
        git add README.md .gitignore
        git commit -m "feat: initial project setup"
    fi
    
    echo "Project '$1' created with structure:"
    tree . 2>/dev/null || ls -la
}

# Extract any archive format
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick HTTP server for current directory
serve() {
    local port=${1:-8000}
    echo "Starting HTTP server on http://localhost:$port"
    echo "Serving: $(pwd)"
    python3 -m http.server "$port"
}

# Find files by name
findfile() {
    find . -name "*$1*" -type f
}

# Find directories by name (using different name to avoid conflict with fd command)
finddir() {
    find . -name "*$1*" -type d
}

# Kill process by port
killport() {
    if [[ -z "$1" ]]; then
        echo "Usage: killport <port>"
        return 1
    fi
    
    local pid=$(lsof -ti:$1)
    if [[ -n "$pid" ]]; then
        echo "Killing process $pid on port $1"
        kill -9 $pid
    else
        echo "No process found on port $1"
    fi
}

# Get public IP and location
ipinfo() {
    echo "Public IP:"
    curl -s ifconfig.me && echo
    echo -e "\nLocation info:"
    curl -s ipinfo.io
}

# Show listening ports with process info
listening() {
    echo "Listening ports and processes:"
    lsof -i -P -n | grep LISTEN | awk '{print $1, $2, $9}' | column -t
}

# Quick backup of a file
backup() {
    if [[ -f "$1" ]]; then
        cp "$1" "$1.backup.$(date +%Y%m%d-%H%M%S)"
        echo "Backed up $1"
    else
        echo "File $1 not found"
    fi
}

# Load project-specific environment (if .envrc or similar exists)
load_project_env() {
    # Check for various project environment files
    if [[ -f ".nvmrc" ]] && command -v nvm > /dev/null; then
        echo "Loading Node.js version from .nvmrc"
        nvm use
    fi
    
    if [[ -f "Pipfile" ]] && command -v pipenv > /dev/null; then
        echo "Pipenv project detected"
        echo "Run 'pipenv shell' to activate"
    fi
    
    if [[ -f "pyproject.toml" ]] && command -v poetry > /dev/null; then
        echo "Poetry project detected"
        echo "Run 'poetry shell' to activate"
    fi
    
    if [[ -f "package.json" ]]; then
        echo "NPM project detected"
        if [[ -f "yarn.lock" ]]; then
            echo "Run 'yarn install' to install dependencies"
        else
            echo "Run 'npm install' to install dependencies"
        fi
    fi
    
    if [[ -f "Cargo.toml" ]]; then
        echo "Rust project detected"
        echo "Run 'cargo build' to build"
    fi
    
    if [[ -f "go.mod" ]]; then
        echo "Go project detected"
        echo "Run 'go mod tidy' to clean dependencies"
    fi
}