# dotfiles

My Chezmoi managed dotfiles.

## Bootstrap a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rescriba01
```

This applies all tracked files and runs `run_once_after_macos-defaults.sh`
(Dock/keyboard/Finder/screenshot preferences) and the Homebrew installer
script (formulae, casks, Mac App Store apps, VS Code extensions).

## Manual steps not covered by chezmoi

A few tools can't be scripted end-to-end and need a manual step after the
bootstrap above:

- **iTerm2**: restart the app, then check Preferences → General →
  Preferences that "Load preferences from a custom folder or URL" is
  checked and pointed at `~/.config/iterm2-prefs`. From then on iTerm2
  keeps that file live-synced; run `chezmoi re-add` periodically to pull
  in changes.
- **Raycast**: `dot_config/raycast/raycast-export.rayconfig` is a
  point-in-time encrypted export (AES-256, passphrase required), not a
  live sync. Before an actual migration, redo the export via Raycast →
  Settings → Advanced → Export Settings & Data, then
  `chezmoi add ~/.config/raycast/raycast-export.rayconfig` to refresh it.
  Import on the new machine via Raycast → Settings → Advanced → Import.
  The export passphrase lives in the macOS Keychain (Raycast manages it
  automatically for scheduled exports) — this assumes iCloud Keychain
  sync carries it to the new machine; if it doesn't, reset the passphrase
  in Raycast and save the new one to 1Password before wiping the old Mac.
- **SSH**: `~/.ssh/config` points `IdentityAgent` at 1Password's SSH agent
  socket. On a new machine: install 1Password, sign in, enable Settings →
  Developer → "Use the SSH agent" — the `rescriba01-github` key (stored in
  the Private vault) syncs automatically and GitHub already trusts it, no
  key file to restore. `id_rsa` is kept as a config fallback for now but
  isn't required for anything currently in use; safe to prune later along
  with its GitHub entry ("Personal Mac").
- **gh CLI**: not tracked (its token lives in Keychain, not a dotfile).
  Run `gh auth login` on the new machine. If `gh ssh-key add` is ever
  needed again, the token also needs the `admin:public_key` scope:
  `gh auth refresh -h github.com -s admin:public_key`.
