#!/bin/bash
# Read-only inventory of a Mac's apps, packages, and editor setup.
# Writes plain-text reports to ./mac-inventory-<hostname>/ for review.
# Changes nothing on the machine and does not read secrets or credentials.
#
#   bash inventory-mac.sh [output-dir]

set -u
out="${1:-./mac-inventory-$(scutil --get LocalHostName 2>/dev/null || hostname -s)}"
mkdir -p "$out"
echo "Writing inventory to $out"

run() { # run <file> <command...>: capture output, ignore missing tools
  local file="$1"; shift
  "$@" >"$out/$file" 2>/dev/null || true
}

# System
run system.txt sh -c 'sw_vers; uname -m; sysctl -n machdep.cpu.brand_string'

# Applications (including ones not installed through Homebrew)
run applications.txt sh -c 'ls -1 /Applications ~/Applications 2>/dev/null | sort -u'
run mas.txt mas list

# Homebrew
if command -v brew >/dev/null; then
  run brew-taps.txt brew tap
  run brew-leaves.txt brew leaves
  run brew-casks.txt brew list --cask
  run Brewfile brew bundle dump --file=-
fi

# Language/tool managers
run npm-global.txt npm ls -g --depth=0
run pipx.txt pipx list --short
run uv-tools.txt uv tool list
run composer-global.txt composer global show

# VS Code: default profile plus every named profile (e.g. an email-dev profile)
if command -v code >/dev/null; then
  code_user="$HOME/Library/Application Support/Code/User"
  run vscode-extensions-default.txt code --list-extensions --show-versions
  if [ -f "$code_user/globalStorage/storage.json" ] && command -v jq >/dev/null; then
    jq -r '.userDataProfiles[]? | "\(.location)\t\(.name)"' \
      "$code_user/globalStorage/storage.json" >"$out/vscode-profiles.txt" 2>/dev/null
    while IFS=$'\t' read -r _ name; do
      [ -n "$name" ] || continue
      safe=$(printf '%s' "$name" | tr -c 'A-Za-z0-9._-' '_')
      run "vscode-extensions-profile-$safe.txt" code --profile "$name" --list-extensions --show-versions
    done <"$out/vscode-profiles.txt"
  fi
  # List (not copy) the config files so you can decide what to capture
  run vscode-user-files.txt find "$code_user" -maxdepth 3 \
    \( -name 'settings.json' -o -name 'keybindings.json' -o -path '*/snippets/*' -o -name 'tasks.json' \) \
    -not -path '*/workspaceStorage/*' -not -path '*/History/*'
fi
run cursor-extensions.txt cursor --list-extensions

# Dotfiles and config directories present in $HOME
run home-dotfiles.txt sh -c 'ls -1dA ~/.[!.]* | sed "s|$HOME|~|"'
run config-dirs.txt sh -c 'ls -1A ~/.config'
run chezmoi-unmanaged.txt chezmoi unmanaged --path-style=relative

# Login items, user LaunchAgents, fonts
run launch-agents.txt ls -1 ~/Library/LaunchAgents
run user-fonts.txt ls -1 ~/Library/Fonts
run login-items.txt osascript -e 'tell application "System Events" to get the name of every login item'

# Shell
run shell.txt sh -c 'echo "$SHELL"; ls -1 ~/.zshrc ~/.zprofile ~/.bashrc ~/.bash_profile ~/.oh-my-zsh 2>/dev/null'

# Drop empty reports so the folder only shows what exists
find "$out" -type f -empty -delete
echo "Done. Review $out, then delete anything confidential before sharing it."
