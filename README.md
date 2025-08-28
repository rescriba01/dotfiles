# Red's Dotfiles

A clean, organized collection of dotfiles optimized for modern CLI workflows. Built around a minimal zsh setup with contemporary development tools.

## Philosophy

Moving away from oh-my-zsh bloat toward a curated, maintainable setup. Focus on tools that enhance productivity without adding unnecessary overhead.

## Core Tools

- **Shell**: Zsh (minimal, no oh-my-zsh)
- **Prompt**: Starship
- **Git UI**: Lazygit
- **Editor**: Neovim/LazyVim (+ VS Code/Cursor)
- **File Listing**: LSD
- **Terminal Enhancements**: zsh-autosuggestions, zsh-syntax-highlighting

## Structure

```
.dotfiles/
├── bin/           # Custom scripts and executables
├── cursor/        # Cursor editor configurations
├── docker/        # Docker-related configurations
├── git/           # Git configurations and aliases
├── homebrew/      # Brew bundle and package lists
├── macos/         # macOS system preferences
├── node/          # Node.js and npm configurations
├── php/           # PHP and Composer configurations
├── python/        # Python environment setup
├── script/        # Installation and setup scripts
├── vscode/        # VS Code settings and extensions
├── wordpress/     # WordPress development tools
└── zsh/           # Zsh configuration and aliases
```

## Installation

```bash
# Clone repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

# Run installation script
cd ~/.dotfiles
./script/bootstrap
```

## Quick Setup

### Essential CLI Tools
```bash
# Install modern CLI replacements
brew install starship zsh-autosuggestions zsh-syntax-highlighting
brew install lazygit neovim lsd fzf bat
```

### Symlink Key Files
```bash
# Zsh configuration
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Git configuration  
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Starship prompt
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
```

## Development Focus

Optimized for:
- **Frontend Development** (JavaScript, Node.js, React)
- **WordPress Development** (PHP, Composer, WP-CLI)
- **Full-Stack Workflows** (Laravel learning path)
- **Modern CLI Tools** (Lazygit, Neovim, Starship)

## Project Management

Quick access aliases for common development paths:
- WordPress themes and plugins
- Bedrock/Sage projects
- Sandbox environments
- Code editor workspaces

## Maintenance

- Keep configurations minimal and well-documented
- Prioritize human-readable code over brevity
- Regular cleanup of unused aliases and configurations
- Test changes before committing

## Notes

- Transitioning from oh-my-zsh to minimal setup
- Building up plugins manually for better understanding
- Focus on tools that enhance rather than complicate workflow
- Optimized for ADHD-friendly organization (clear structure, minimal cognitive load)

---

> *"Simple, clean, functional - just like good code."*
