# Personal Macs: PATH and environment (loaded early in ~/.zshrc)

# PATH configurations
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Applications/Cursor.app/Contents/MacOS"
export PATH=$PATH:$HOME/.composer/vendor/bin
source ~/.config/zsh/homebrew.zsh
VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:${PATH}"

# Extra oh-my-zsh plugins
extra_omz_plugins=(yarn)
