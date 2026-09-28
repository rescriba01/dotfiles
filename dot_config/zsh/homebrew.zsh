# Finds Homebrew wherever this machine has it and sets PATH, MANPATH and
# HOMEBREW_PREFIX. Sourced from .zprofile and .zshrc.
#   /opt/homebrew  Apple Silicon default
#   /usr/local     Intel default
#   ~/.homebrew    non-admin install; builds everything from source
for _brew_prefix in /opt/homebrew /usr/local "$HOME/.homebrew"; do
  if [[ -x "$_brew_prefix/bin/brew" ]]; then
    eval "$("$_brew_prefix/bin/brew" shellenv)"
    break
  fi
done
unset _brew_prefix

# Without admin rights, casks can't write to /Applications
[[ -w /Applications ]] || export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
