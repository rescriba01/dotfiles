# Personal Macs: aliases and functions (loaded after oh-my-zsh)

# cd into dotfiles or open in Neovim
alias dotfiles="cd ~/.dotfiles"
alias lazydot="nvim ~/.dotfiles"

# Open lazyvim
alias lz="nvim"

# Open zshrc in Lazyvim
alias lazyzsh="nvim ~/.zshrc"

# PHP Coding Standards WordPress
alias phpcs-wp="~/.composer/vendor/bin/phpcs -ps --standard=WordPress"

# List improvements
alias ls='lsd -lAFh'
alias la='lsd -A'
alias ll='lsd -l'
alias lt='lsd --tree'
alias llt='lsd --tree --group-directories-first --depth 3 --date relative --git --long'

# Git shortcuts (for quick terminal operations)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# Chezmoi shortcuts
alias cm='chezmoi'
alias cma='chezmoi add'
alias cme='chezmoi edit'
alias cmcd='chezmoi cd'
alias cmap='chezmoi apply'

# Config file quick access
# alias zshrc="code ~/.zshrc"
# alias cursor_zshrc="cursor ~/.zshrc"

# Open files in VS Code
# alias open_bs="code ~/Sites/bedrock-sage"
# alias open_flir="code ~/Sites/FLIR"
# alias open_webfun="code ~/Sites/web-fun"
# alias open_wp-container="code ~/Sites/wp-container"
# alias open_sandboxes="code ~/Sites/sandboxes/"
# alias open_one-impulse="code ~/DevKinsta/public/one-impulse/one-impulse.code-workspace"

# Open files in Cursor
# alias cursor_bs="cursor ~/Sites/bedrock-sage"
# alias cursor_flir="cursor ~/Sites/FLIR"
# alias cursor_webfun="cursor ~/Sites/web-fun"
# alias cursor_wp-container="cursor ~/Sites/wp-container"
# alias cursor_sandboxes="cursor ~/Sites/sandboxes/"
# alias cursor_one-impulse="cursor ~/DevKinsta/public/one-impulse/one-impulse.code-workspace"
# alias cursor_portfolio="cursor ~/'Local Sites'/rafaelescribano/app/public/wp-content/themes/re/re.code-workspace"

# WordPress Themes
alias open_themes="code ~/Work/wp-themes.code-workspace"
alias open_greekfries="code ~/Work/wp-themes/greek-fries/greek-fries.code-workspace"
alias cursor_themes="cursor ~/Work/wp-themes.code-workspace"
alias cursor_greekfries="cursor ~/Work/wp-themes/greek-fries/greek-fries.code-workspace"

# Lazyvim
alias lazy_re="~/'Local Sites'/rafaelescribano/app/public/wp-content/themes/re/"

# WordPress Plugins
alias open_wp-plugins="code ~/Work/wp-plugins/wp-plugins.code-workspace"
alias open_1ibl="code ~/Work/wp-plugins/one-impulse-block-library/one-impulse-block-library.code-workspace"
alias cursor_wp-plugins="cursor ~/Work/wp-plugins/wp-plugins.code-workspace"
alias cursor_1ibl="cursor ~/Work/wp-plugins/one-impulse-block-library/one-impulse-block-library.code-workspace"

# Directory Navigation
alias cd_bs="cd ~/Sites/bedrock-sage"
alias cd_flir="cd ~/Sites/FLIR"
alias cd_webfun="cd ~/Sites/web-fun"
alias cd_wp-container="cd ~/Sites/wp-container"
alias cd_sandboxes="cd ~/Sandboxes/"
alias cd_one-impulse="cd ~/DevKinsta/public/one-impulse"
alias cd_themes="cd ~/Work/wp-themes"
alias cd_greekfries="cd ~/Work/wp-themes/greek-fries"

# Working in themes (symlinking)
alias setup-theme-link='mkdir -p ~/DevKinsta/public/one-impulse/wp-content/themes && rm -rf ~/DevKinsta/public/one-impulse/wp-content/themes/one-impulse-block-theme && ln -s ~/Work/wp-themes/greek-fries/one-impulse-block-theme ~/DevKinsta/public/one-impulse/wp-content/themes/one-impulse-block-theme && echo "Symbolic link created for one-impulse-block-theme"'
