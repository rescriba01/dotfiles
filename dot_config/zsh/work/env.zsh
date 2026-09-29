# Work Macs: PATH and environment (loaded early in ~/.zshrc)

# PATH configurations
export PATH="$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH"  # Local Homebrew FIRST
export PATH=$HOME/bin:$PATH  # Remove the /usr/local/bin part
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=$PATH:$HOME/.composer/vendor/bin

# npm Environment Variable for installing LSP's via Mason in Neovim
export NODE_TLS_REJECT_UNAUTHORIZED=0
export NPM_CONFIG_STRICT_SSL=false
export NPM_CONFIG_REGISTRY=http://registry.npmjs.org/

# Homebrew cask configuration
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"

# Starship prompt for this machine type (the company label comes from
# STARSHIP_ORG_LABEL, set in ~/.zshrc.local)
export STARSHIP_CONFIG="$HOME/.config/starship/work.toml"
