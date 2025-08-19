# Improved Installation Process

## 🚀 Quick Start

Run this single command to set up everything:

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/personal-dotfiles/main/bootstrap.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/yourusername/personal-dotfiles.git ~/personal-dotfiles
cd ~/personal-dotfiles
./bootstrap.sh
./install.sh
```

## 📋 Installation Scripts

### `bootstrap.sh` - Initial System Setup
- ✅ Installs Xcode Command Line Tools
- ✅ Installs/updates Homebrew
- ✅ Clones dotfiles repository
- ✅ Installs essential tools (stow, antidote)
- ✅ Sets up zsh as default shell
- ✅ Creates necessary directories

### `install.sh` - Dotfiles Configuration
- ✅ Backs up existing configurations
- ✅ Installs Homebrew packages from Brewfile
- ✅ Symlinks all dotfile configurations
- ✅ Provides detailed logging
- ✅ Handles errors gracefully

## 🔄 What Gets Installed

### Essential Tools
- **GNU Stow** - Symlink farm manager
- **Antidote** - Fast zsh plugin manager
- **Homebrew** - Package manager for macOS

### Development Tools
- **Git**, **Neovim**, **Zellij** (terminal multiplexer)
- **Ripgrep**, **fd**, **bat**, **eza** (modern CLI tools)
- **fzf** (fuzzy finder), **zoxide** (smart cd)
- **lazygit**, **lazydocker** (TUI applications)

### Applications
- **Alfred**, **iTerm2**, **Wezterm**
- **JetBrains Toolbox**, **Sublime Text**, **Zed**
- **Docker**, **Postman** (development)
- **VLC**, **Discord**, **Telegram** (media/communication)

## 🛡️ Safety Features

- **Automatic Backup**: Existing configs backed up to `~/.dotfiles-backup-TIMESTAMP`
- **Dependency Checks**: Verifies required tools before proceeding
- **Error Handling**: Graceful failure with informative messages
- **Detailed Logging**: Full logs saved to `~/.dotfiles-install.log`

## 📁 Directory Structure

After installation, your `~/personal-dotfiles` will contain:

```
personal-dotfiles/
├── bootstrap.sh          # Initial system setup
├── install.sh            # Dotfiles installation
├── brew/Brewfile         # Homebrew packages
├── zsh/                  # Zsh configuration
├── zellij/               # Terminal multiplexer config
├── alfred/               # Alfred preferences & workflows
├── aliases/              # Shell aliases
├── exports/              # Environment variables
└── [other configs...]    # Additional tool configurations
```

## 🔧 Customization

1. **Fork this repository** to your GitHub account
2. **Update URLs** in bootstrap.sh (line for cloning repository)
3. **Modify Brewfile** to add/remove packages
4. **Customize configurations** in respective directories

## 📝 Post-Installation

After running the scripts:

1. **Restart terminal** or run `source ~/.zshrc`
2. **Configure Powerlevel10k**: Run `p10k configure`
3. **Set up Git**: Configure your name and email
4. **Review backups**: Check `~/.dotfiles-backup-*` if needed

## 🆘 Troubleshooting

- **Check logs**: `tail -f ~/.dotfiles-install.log`
- **Manual backup restore**: Copy from `~/.dotfiles-backup-*`
- **Reinstall package**: `cd ~/personal-dotfiles && stow -R package-name`
- **Clean install**: Remove `~/personal-dotfiles` and start over