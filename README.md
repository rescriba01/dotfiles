# Red's Dotfiles

A clean, organized collection of dotfiles optimized for modern CLI workflows. Built around a minimal zsh setup with contemporary development tools, managed with GNU Stow for easy deployment and maintenance.

## Philosophy

Moving away from config file bloat toward a curated, maintainable setup. Focus on tools that enhance productivity without adding unnecessary overhead. Using Stow for symlink management ensures consistent deployments across machines.

## Core Tools

- **Shell**: Zsh with modern enhancements
- **Prompt**: Starship
- **Git UI**: Lazygit
- **Editor**: Neovim/LazyVim + VS Code/Cursor
- **File Management**: LSD for enhanced directory listings
- **Package Management**: Stow for dotfile deployment

## Structure

```shell
.dotfiles/
├── .git/                   # Git repository metadata
├── README.md               # This documentation
├── bootstrap/              # Initial setup scripts (planned)
├── scripts/                # Utility scripts
│   └── move-to-stow.sh         # Migration helper script
└── stow/                   # Stow packages (symlink sources)
  ├── bin/                    # Custom scripts and executables
  ├── cursor/               # Cursor editor configurations
  ├── docker/               # Docker-related configurations
  ├── git/                  # Git configurations and GitHub CLI
  ├── homebrew/             # Brew bundle and package lists
  ├── macos/                # macOS system preferences
  ├── node/                 # Node.js and npm configurations
  ├── php/                  # PHP and Composer configurations
  ├── python/               # Python environment setup
  ├── raycast/              # Raycast configurations and scripts
│   ├── applescripts/          # AppleScript extensions
│   ├── obsidian/              # Obsidian integration scripts
│   ├── shell/                 # Shell command extensions
│   └── wordpress/             # WordPress-specific scripts
  ├── vscode/               # VS Code settings and extensions
  ├── wordpress/            # WordPress development tools
  └── zsh/                  # Zsh configuration and aliases
```

## Configuration Status

**Currently in `.config/` (managed):**

- `starship.toml` → Needs migration to `stow/starship/`
- `nvim/` → Needs migration to `stow/nvim/`
- `raycast/` → Needs migration to `stow/raycast/`
- `gh/` → Should move into `stow/gh/`

**Root configs to migrate:**

- `.gitconfig`, `.gitignore_global`, `.gitmessage` → `stow/git/`
- `.zshrc`, `.zprofile`, `.p10k.zsh` → `stow/zsh/`
- Node/npm configs → `stow/node/`

## Installation & Usage

### Prerequisites

```shell
# Install Stow (if not already installed)
brew install stow

# Clone repository
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

## Quick Commands

```Shell
# List current stow packages
ls ~/.dotfiles/stow/

# Check what files would be symlinked
stow --dir=~/.dotfiles/stow --target=~/ --simulate <package>

# Remove a stow package deployment  
stow --dir=~/.dotfiles/stow --target=~/ --delete <package>

# Restow (useful after config changes)
stow --dir=~/.dotfiles/stow --target=~/ --restow <package>
```

### Deploy Individual Packages

```shell
# Zsh configuration
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Git configuration  
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Starship prompt
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
```

### Safe Migration Process

```shell
# Test deployment first (dry run)
stow --dir=~/.dotfiles/stow --target=~/ --simulate git --verbose

# Create backup before migration
cp ~/.gitconfig ~/dotfiles_backup_$(date +%Y%m%d)/

# Copy to stow structure, then deploy
cp ~/.gitconfig ~/.dotfiles/stow/git/
stow --dir=~/.dotfiles/stow --target=~/ git
```

## Development Focus

Optimized for:

- **Frontend Development** (JavaScript, Node.js, React)
- **WordPress Development** (PHP, Composer, WP-CLI)
- **Full-Stack Workflows** (Laravel learning path)
- **Modern CLI Tools** (Lazygit, Neovim, Starship)

## Project Management

Workflow Optimization:

- Quick access to development environments
- Streamlined Git workflows with aliases
- Consistent editor configurations across projects
- Automated setup for new development machines

## Maintenance

- Keep configurations minimal and well-documented
- Test stow deployments before committing changes
- Regular cleanup of unused aliases and configurations
- Version control all configuration changes

## Migration Goals

- Move remaining root configs into stow packages
- Complete migration of remaining .config/ items
- Implement bootstrap script for fresh installations

## Notes

- *Transitioning to Stow-based management for better organization*
- *Prioritizing human-readable configurations over brevity*
- *Focus on tools that enhance rather than complicate workflow*
- *Optimized for ADHD-friendly organization (clear structure, minimal cognitive load)*
- *All symlinks point back to version-controlled source files*

---

> *"Simple, clean, functional - just like good code."*
