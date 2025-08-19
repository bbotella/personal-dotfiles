# Zellij Improvements Documentation

## 🚀 **What's Been Added**

Your **default Zellij setup remains unchanged**. I've added **optional layouts and tools** that you can use when you need them.

## 📋 **New Optional Layouts**

### **1. System Administration Layout**
```bash
zellij --layout sysadmin
# or: zj-sys
```
- **Main terminal** for commands (60%)
- **System monitor** with btop (40% top)
- **Logs pane** for services (40% bottom)
- Perfect for server management tasks

### **2. Docker/Container Management**
```bash
zellij --layout docker
# or: zj-docker
```
- **Docker commands** terminal
- **Kubernetes commands** terminal  
- **LazyDocker** TUI for container monitoring
- **Logs pane** for container output

### **3. Development Support** (for occasional terminal coding)
```bash
zellij --layout dev
# or: zj-dev
```
- **Main editor area** (70% width)
- **Yazi file browser** (30% top-right)
- **LazyGit** for version control (30% middle-right)
- **General terminal** (30% bottom-right)

### **4. Work Project Layout**
```bash
zellij --layout work
# or: zj-work
```
- **Auto-opens in your Xerador project** directory
- **Project terminal** for main commands
- **Cassandra management** pane
- **Build/deploy** pane
- **Logs/monitoring** pane

## 🎯 **New Aliases & Commands**

### **Quick Session Launcher**
```bash
zjs help                    # Show all options
zjs default my-session      # Standard session
zjs sysadmin server-work    # System admin layout
zjs docker containers       # Docker management
zjs work xerador            # Work project
```

### **Convenient Aliases**
```bash
zj                  # Short for zellij
zjs                 # Session launcher script
zj-sys              # System admin layout
zj-docker           # Docker layout
zj-work             # Work project layout
zj-dev              # Development layout

# Session management
zj-list             # List all sessions
zj-kill <session>   # Kill a session
zj-attach <session> # Attach to session
```

## 🔧 **Your Default Setup**

**Nothing has changed** with your normal usage:
- `zellij` still opens your standard session
- All your keybindings work exactly the same
- Your catppuccin-mocha theme is unchanged
- Your custom keybindings are preserved

## 📁 **File Structure**

```
zellij/.config/zellij/
├── config.kdl              # Your existing config (unchanged)
├── layouts/                # New optional layouts
│   ├── sysadmin.kdl       # System administration
│   ├── docker.kdl         # Container management  
│   ├── dev.kdl            # Development support
│   └── work.kdl           # Work project
└── ...

scripts/
└── zellij-session         # Session launcher script

aliases/
├── .aliases.sh            # Updated with Zellij aliases
└── .zellij-aliases.sh     # Zellij-specific aliases
```

## 🎮 **Usage Examples**

### **Daily System Administration**
```bash
# Start system monitoring session
zj-sys monitoring

# In the session:
# - Main pane: run commands, check logs
# - Monitor pane: btop shows system resources
# - Logs pane: tail important service logs
```

### **Docker Development**
```bash
# Start container management session
zj-docker myproject

# In the session:
# - Docker pane: docker-compose up, docker ps
# - K8s pane: kubectl commands  
# - LazyDocker pane: visual container management
# - Logs pane: container logs
```

### **Work Project**
```bash
# Auto-opens in your Xerador project
zj-work cassandra-dev

# In the session:
# - Project pane: already in your project directory
# - Cassandra pane: ccm commands, cqlsh
# - Build pane: gradle builds, tests
# - Logs pane: application logs
```

## 💡 **Tips**

1. **Your default remains default**: Just run `zellij` as normal
2. **Try layouts when needed**: Use specific layouts for focused tasks
3. **Session naming**: Give sessions descriptive names for easy switching
4. **Layout customization**: Edit `.kdl` files in `layouts/` to adjust layouts
5. **Add more layouts**: Copy existing ones and modify for your workflows

## 🔄 **Session Management**

```bash
# List all running sessions
zj-list

# Switch between sessions
zj-attach <session-name>

# Kill unused sessions
zj-kill <session-name>

# Detach from current session
Ctrl+o d  # (your existing keybinding)
```

Your Zellij setup now has **powerful optional features** while keeping your preferred default workflow intact!