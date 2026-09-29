# Work Macs: aliases and functions (loaded after oh-my-zsh)

# Open zshrc with VS Code 
alias zshrc="code ~/.zshrc"

# `cd` into Dev Directory and open nvim
unalias dev 2>/dev/null  # Remove any existing alias
dev() {
    local base_dir=~/Dev
    
    # If no argument, just go to Dev root
    if [ -z "$1" ]; then
        cd "$base_dir" || return
        nvim
        return
    fi
    
    # Map shortcuts to parent directories
    case "$1" in
        apps|app|a)
            cd "$base_dir/Apps" || return
            ;;
        email|emails|e)
            cd "$base_dir/Emails" || return
            ;;
        laravel|lara|l)
            cd "$base_dir/Laravel" || return
            ;;
        scratch|s)
            cd "$base_dir/scratch files" || return
            ;;
        sites|si)
            cd "$base_dir/Sites" || return
            ;;
        sports|se)
            cd "$base_dir/Sport Events" || return
            ;;
        umbraco|u)
            cd "$base_dir/Umbraco" || return
            ;;
          *)
            echo "Unknown directory: $1"
            echo "Available: apps(a), emails(e), laravel(l), scratch(s), sites(si), sports(se), umbraco(u)"
            return 1
            ;;
    esac
    
    nvim
}

# lsd with long listing by default
alias lsd='lsd -lAFh'        # redundant but explicit

# Tree Command with colorization and numbered Directories
unalias tre 2>/dev/null  # Remove any existing tre alias first
tre() { command tre "$@" -a && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

alias tre1='tre -l 1'
alias tre2='tre -l 2'
alias tred='tre -d -l 2'
alias tree='tre -l 3'

# Editor aliasing versions
alias tee='tre -e'
alias tee1='tre -e -l 1'
alias tee2='tre -e -l 2'
