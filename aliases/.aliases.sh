alias cat="bat"
alias ggb="./gradlew clean && ./gradlew build"
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"
alias lst="eza --tree --level=2"
alias vim="nvim"
alias vi="nvim"

# Git aliases (complement the ones in .gitconfig)
alias g="git"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gf="git fetch"
alias gr="git rebase"
alias gm="git merge"
alias glog="git log --oneline --graph --decorate"

# Git utility scripts
alias git-cleanup="~/personal-dotfiles/scripts/git-cleanup"
alias git-stats="~/personal-dotfiles/scripts/git-stats"
alias install-git-hooks="~/personal-dotfiles/scripts/install-git-hooks"

# SSH utilities
alias ssh-helper="~/personal-dotfiles/scripts/ssh-helper"

# Zellij aliases
alias zj="zellij"
alias zjs="~/personal-dotfiles/scripts/zellij-session"
alias zj-sys="zellij --layout sysadmin"
alias zj-docker="zellij --layout docker"
alias zj-work="zellij --layout work"
alias zj-dev="zellij --layout dev"

# Zellij session management
alias zj-list="zellij list-sessions"
alias zj-kill="zellij kill-session"
alias zj-attach="zellij attach"

# Load development-specific aliases and functions
if [[ -f ~/.dev-aliases.sh ]]; then
  source ~/.dev-aliases.sh
fi
