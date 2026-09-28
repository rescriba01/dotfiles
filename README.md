# dotfiles

My Chezmoi managed dotfiles.

## Keeping machines in sync

`chezmoi init` asks once per machine and keeps the answers in
`~/.config/chezmoi/chezmoi.toml`, never in this repo:

- **Machine type**, `personal` or `work`. It picks the package sections
  (`.chezmoidata/packages.yaml`), whether the machine may push, and whether
  the SSH config uses 1Password's agent (personal only).
- **Work git email**, on work machines only.
- **Daily sync**, on or off. The default is on for personal machines and
  off for work machines.

It also detects whether the account is an admin. Non-admin machines never
install Homebrew themselves and skip Mac App Store apps.

When the daily sync is on, `~/bin/chezmoi-sync` runs at 10:00 via launchd
(`~/Library/Logs/chezmoi-sync.log`):

- Pulls `main` and applies incoming changes.
- Local edits are never overwritten. On personal machines they're committed to
  `sync/<host>` and pushed, with a notification. Merge the branch on GitHub
  (or cherry-pick), then delete it. Work machines only notify.
- Packages installed but missing from `packages.yaml` are listed in
  `sync-reports/<host>.md` on the review branch. Copy them into the right
  section of `packages.yaml` by hand.
- Package-list changes aren't installed automatically; it notifies you to run
  `chezmoi apply`.

`chezmoi-sync --dry-run` shows what it would do. A
[Betterleaks](https://betterleaks.com) pre-commit hook blocks commits
containing secrets (and refuses to commit if Betterleaks is missing).
Homebrew installs it on Apple Silicon. On Intel Macs, Homebrew would have to
compile it, so install the release binary instead: download
`betterleaks_<version>_darwin_x64.tar.gz` from
[its releases](https://github.com/betterleaks/betterleaks/releases), check it
against `checksums.txt`, and put `betterleaks` in `~/bin`. The repo fetches over HTTPS and pushes over
SSH (1Password agent), so pushes need 1Password unlocked.

## Work machines (no admin rights)

One Mac I use has no admin account, so the personal checklist below
doesn't apply. Differences:

- **Homebrew lives in `~/.homebrew`**, installed without admin by cloning
  `github.com/Homebrew/brew` there. `~/.config/zsh/homebrew.zsh` finds it
  (as well as the standard `/opt/homebrew` and `/usr/local`) and sends casks
  to `~/Applications` when `/Applications` isn't writable. Outside the
  standard location Homebrew has no prebuilt bottles, so **every formula
  compiles from source**. `wget` alone means building OpenSSL and running
  its test suite.
- **Packages:** work machines install only the `work` section of
  `packages.yaml`, not `common`. Keep it short, since everything there
  compiles. Claude Code is in the personal section only.
- **No 1Password there.** SSH uses macOS's built-in agent, and the repo is
  pulled over HTTPS, so no key is needed. Work machines never push.
- **Git email:** the work address you enter at `init`.

Bootstrap without `--apply`, and review before anything is overwritten:

```sh
cd ~ && sh -c "$(curl -fsLS get.chezmoi.io)"   # installs chezmoi into ~/bin
~/bin/chezmoi init rescriba01                   # answer: work, work email, daily sync
cp ~/.zshrc ~/.zshrc.pre-chezmoi                # keep the current one
~/bin/chezmoi diff                              # review what would change
~/bin/chezmoi apply
```

## New machine migration checklist

### 0. On the OLD machine, right before migration day

- [ ] Redo the Raycast export (Raycast → Settings → Advanced → Export
      Settings & Data) so it's current, then:
      ```sh
      cp ~/.config/raycast/"Raycast <new-timestamp>.rayconfig" ~/.config/raycast/raycast-export.rayconfig
      chezmoi add ~/.config/raycast/raycast-export.rayconfig
      ```
      commit and push. (The tracked copy is a point-in-time snapshot, not
      a live sync — it goes stale the moment anything changes in Raycast.)
- [ ] Run `chezmoi re-add` and skim the diff for anything uncommitted
      (`.zshrc` tweaks, nvim config changes, etc.), commit and push.
- [ ] Keep the old machine powered on and reachable for a while after
      the new one is up — don't wipe it until everything below is
      verified.

### 1. New machine: before touching chezmoi

- [ ] Complete macOS setup, sign into the Apple ID (iCloud Keychain
      sync is what carries the Raycast export passphrase over).
- [ ] Install 1Password, sign in to the account.
- [ ] 1Password → Settings → Developer → enable "Use the SSH agent".
      The `rescriba01-github` key (Private vault) syncs automatically —
      no key file to restore, GitHub already trusts it.
- [ ] Sign into the App Store (needed for `mas` to install the Mac App
      Store apps declared in the Brewfile).

### 2. Bootstrap chezmoi

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rescriba01
```

Answer the prompts (`personal`, daily sync yes). This applies all
tracked dotfiles, runs `run_once_after_macos-defaults.sh`
(Dock/keyboard/Finder/screenshot preferences), and runs the Homebrew
installer script (formulae, casks, Mac App Store apps, VS Code
extensions). It'll prompt for the admin password once, for Homebrew's
own install — that's normal. This step takes a while; it's installing
~50 formulae, ~23 casks, and ~50 VS Code extensions.

### 3. Manual steps chezmoi can't fully automate

- [ ] **iTerm2**: restart the app, then check Preferences → General →
      Preferences that "Load preferences from a custom folder or URL"
      is checked and pointed at `~/.config/iterm2-prefs`. From then on
      iTerm2 keeps that file live-synced; run `chezmoi re-add`
      periodically to pull in future changes.
- [ ] **Raycast**: Settings → Advanced → Import, point it at
      `~/.config/raycast/raycast-export.rayconfig`. You'll need the
      export passphrase — check 1Password if it wasn't carried over via
      iCloud Keychain.
- [ ] **gh CLI**: run `gh auth login` (the token lives in Keychain, not
      a dotfile, so it never transfers). If `gh ssh-key add` is ever
      needed again, the token also needs the `admin:public_key` scope:
      `gh auth refresh -h github.com -s admin:public_key`.
- [ ] **SSH sanity check**: `ssh -T git@github.com` should greet you by
      username. If it doesn't, confirm 1Password's SSH agent is enabled
      and `ssh-add -L` lists `rescriba01-github`.

### 4. Verify before retiring the old machine

- [ ] Shell: new tab opens with starship prompt, aliases work (`ll`,
      `gs`, `cm`, etc.), `nvim` opens LazyVim cleanly with plugins intact.
- [ ] `git push`/`git pull` work over SSH without a password prompt.
- [ ] VS Code: settings applied, extensions installed, sign into
      Copilot/any account-based extensions.
- [ ] Docker Desktop launches and `docker ps` works.
- [ ] Dock is resizable, screenshots save as PNG to Desktop, Finder
      shows path bar/extensions as expected.
- [ ] Everything above checked off? Then it's safe to wipe/retire the
      old Mac.

## Known gaps / accepted tradeoffs

- `id_rsa` is kept as an SSH config fallback but isn't required for
  anything currently in use (GitHub runs entirely on the 1Password
  agent key). Safe to prune later along with its GitHub entry
  ("Personal Mac").
- The legacy `~/dotfiles` directory (holman-style, pre-chezmoi) is
  intentionally left untouched — not migrated, not deleted. Revisit
  separately.
- This repo is public. A defunct client's staging hostname + admin
  username exists in git history (commit `78990a8`, since removed from
  the current file) — accepted as low-stakes rather than rewriting
  history.
- `php@7.4`, `docker-machine`, `vagrant`, and `virtualbox` were dropped
  from the Brewfile (2026-07-10) ahead of a planned move to an M1 Pro
  MacBook: `php@7.4` has been a disabled formula since 2022-11-28 and
  would fail `brew bundle` outright on a fresh machine; the other three
  are x86-virtualization-era tools with weak Apple Silicon support and
  no remaining use (the Vagrant-based projects they served are dead).
