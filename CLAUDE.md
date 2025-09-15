# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains personal system configuration files and dotfiles for Unix/Linux environments. It includes bash configurations with custom functions and aliases, tmux configurations, vim/neovim configurations, and SSH host configurations.

## Repository Structure

### Core Configuration Files
- `vimrc_updated` - Enhanced vim configuration with plugins and language-specific settings
- `vimrc` - Legacy vim configuration (keep for reference)
- `tmux.conf` - Main tmux configuration with custom key bindings and settings
- `config` - SSH host configurations for various servers and environments

### Bash Configuration (bash/ directory)
- `bashrc` - Main bash configuration with custom prompt, functions, and aliases
- `bash_languages` - Language-specific configurations (Ruby, Python, Go, Node.js, Rust)
- `bash_utilities` - Utility configurations (Docker, Alacritty, Neovim, NVM)
- `bash_pipeline` - CI/CD pipeline-related aliases

### Tmux Profiles (tmuxprofile/ directory)
- `devops.session.sh` - Tmux session layout for development operations
- `devops.sh` - Script to launch devops tmux session
- `operations` - Operations-specific tmux configuration

### Tmux Scripts (tmux/ directory)
- `renew_env.sh` - Environment renewal script
- `yank.sh` - Copy/paste functionality for tmux
- `tmux.conf` - Alternative tmux configuration
- `tmux.remote.conf` - Remote tmux configuration

## Key Features and Functions

### Bash Functions (defined in bash/bashrc)
- `conn()` - SSH wrapper that updates tmux window title
- `mcd()` - Create directory and cd into it
- `extract()` - Universal archive extraction function
- `comstat()` - Show 10 most-used commands from history
- `sysinfo()` - Display system information (CPU, memory, disk)
- `kp()` - Kill process by name wrapper
- `charcount()` - Count characters in a string
- `installed()` - Check if package is installed (Debian/Ubuntu)
- `genpass()` - Generate secure password using pwgen
- `genhash()` - Generate MD5 hash of password
- `gensha()` - Generate SHA-512 hash
- `clip()` - Copy text to clipboard using xclip
- `crawl()` - Recursive grep on directory

### Utility Functions (defined in bash/bash_utilities)
- `setdocker()` - Switch Docker host environments (lab, k8s, containers, local)

### Key Aliases
- `psg` - Process grep
- `lg` - List files grep
- `hg` - History grep
- `netport` - Show listening ports
- `myip` - Get external IP address
- `back` - Return to previous directory
- `gimmeapass` - Generate 16-character password
- `gimmeahash` - Generate SHA-512 hash using Docker

## Language and Tool Support

### Programming Languages
- **Ruby**: rbenv configuration and gem settings
- **Python**: virtualenv wrapper configuration
- **Go**: GOPATH and workspace configuration
- **Node.js**: NVM (Node Version Manager) setup
- **Rust**: Cargo environment for Alacritty builds

### Development Tools
- **Vim/Neovim**: Plugin management with Vundle, syntax checking with Syntastic
- **Tmux**: Custom key bindings, mouse support, session management
- **Docker**: Multi-environment host switching
- **Git**: Basic configuration and aliases
- **SSH**: Pre-configured hosts for various environments

## Environment Setup

### SSH Hosts
The `config` file defines connections to various environments:
- AWS hosts (n9n-bastion, n9n-chef-server)
- Local network hosts (archive, satellite, studiobox, mediabox)
- DigitalOcean hosts (pw, containers, resume, tech)

### Tmux Sessions
- DevOps session with pre-configured windows for installations, Ansible, and Docker
- Custom key bindings: `|` for horizontal split, `-` for vertical split
- Mouse support enabled
- Alt+Arrow keys for pane navigation

### Vim Configuration
- Vundle plugin manager
- Key plugins: NERDTree, CtrlP, Syntastic, vim-airline
- Language-specific formatting and syntax checking
- Custom color schemes and line numbering

## Development Workflow

### File Sourcing Order
1. Main bashrc sources language-specific configurations
2. Language configurations load tool-specific settings
3. Utility configurations add environment-specific functions
4. Pipeline configurations add CI/CD aliases

### Configuration Management
- All configurations are designed to be sourced from this repository location
- Language and utility configurations check for tool existence before loading
- Fallback options provided when tools are not installed
- Environment variables set conditionally based on directory existence

## Notes
- Some configurations reference specific user paths (/home/tthompson, /home/sthompson)
- Docker and AWS ECR configurations are environment-specific
- SSH configurations include private key references that need to exist on target systems
- Python virtualenv configurations assume specific directory structures