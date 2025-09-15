# 🏠 Personal Dotfiles

> Modern, organized, and efficient development environment configuration

A comprehensive collection of dotfiles featuring Neovim, Zsh with Oh My Zsh, terminal multiplexers (Zellij/Tmux), and development tools. Managed with GNU Stow for easy deployment and maintenance.

*Based on [cchacin's dotfiles](https://github.com/cchacin/dotfiles) - thanks for the inspiration!*

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/your-username/personal-dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install dependencies
brew bundle install --file=brew/Brewfile

# Deploy configurations
stow nvim zsh wezterm zellij tmux
```

## 📦 What's Included

### 🎯 **Core Tools**
- **Neovim** - Modern Vim-based editor with LSP, debugging, and plugins
- **Zsh + Oh My Zsh** - Enhanced shell with [Antidote](https://getantidote.github.io) plugin manager and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
- **Zellij/Tmux** - Terminal multiplexers for session management
- **WezTerm** - GPU-accelerated terminal emulator

### ⚙️ **Configuration Highlights**
- **Neovim**: Kickstart-based config with custom plugins and keybindings
- **Zsh**: Optimized aliases, functions, and prompt configuration
- **Terminal**: Modern terminal setup with proper color support
- **Development**: Git configuration, SSH setup, and development aliases

## 📁 Structure

```
├── nvim/           # Neovim configuration
├── zsh/            # Zsh and Oh My Zsh setup
├── wezterm/        # WezTerm terminal configuration
├── zellij/         # Zellij terminal multiplexer
├── tmux/           # Tmux configuration
├── brew/           # Homebrew bundle and formulas
├── ssh/            # SSH configuration
├── scripts/        # Utility scripts
└── templates/      # Configuration templates
```

## 🛠️ Installation

### Prerequisites
- macOS (Darwin)
- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)

### Step-by-Step Setup

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install GNU Stow**:
   ```bash
   brew install stow
   ```

3. **Clone this repository**:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

4. **Install applications and dependencies**:
   ```bash
   brew bundle install --file=brew/Brewfile
   ```

5. **Deploy configurations** (choose what you need):
   ```bash
   # Deploy all configurations
   stow */
   
   # Or deploy specific configurations
   stow nvim
   stow zsh
   stow wezterm
   stow zellij
   ```

## ⌨️ Key Features & Shortcuts

### Neovim Shortcuts
| Shortcut | Action |
|----------|--------|
| `<Space>t` | Toggle Neo-tree file explorer |
| `<Space>sf` | Find files (Telescope) |
| `<Space>sg` | Live grep (Telescope) |
| `<Space>ca` | Code actions (LSP) |
| `<Space>rn` | Rename symbol (LSP) |
| `gd` | Go to definition |
| `K` | Show hover documentation |

### Terminal & Multiplexer
- **Zellij**: Modern terminal multiplexer with Alt+Y for Harpoon integration
- **Tmux**: Traditional terminal multiplexer for session management
- **Enhanced aliases**: Improved `ls`, `grep`, and navigation commands

## 🔧 Management Commands

### Homebrew
```bash
# Install all formulas and casks
brew bundle install --file=brew/Brewfile

# Update Brewfile with currently installed packages
brew bundle dump --file=brew/Brewfile --force
```

### GNU Stow
```bash
# Deploy a configuration
stow <package-name>

# Remove a configuration
stow -D <package-name>

# Simulate deployment (dry run)
stow -n <package-name>
```

### Configuration Updates
```bash
# Pull latest changes
git pull origin main

# Re-deploy configurations after updates
stow */
```

## 🎨 Customization

Each configuration directory contains modular files that can be customized:

- **Neovim**: Edit `nvim/.config/nvim/lua/custom/` for personal customizations
- **Zsh**: Modify `zsh/.zshrc` and plugin configurations
- **Terminal**: Adjust color schemes and fonts in respective config files

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs. If you have improvements or fixes, pull requests are welcome!

## 📚 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Oh My Zsh](https://ohmyz.sh/)
- [Antidote Plugin Manager](https://getantidote.github.io)
- [Powerlevel10k Theme](https://github.com/romkatv/powerlevel10k)
- [Neovim](https://neovim.io/)
- [Homebrew](https://brew.sh/)