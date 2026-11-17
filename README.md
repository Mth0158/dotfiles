My personal dotfiles, originally forked from [Le Wagon's dotfiles](https://github.com/lewagon/dotfiles).

## Install on a new Mac

Install [Cursor](https://cursor.com) and [Docker Desktop](https://docker.com) first (with Cursor's `cursor` shell command), then:

```bash
git clone https://github.com/Mth0158/dotfiles.git ~/code/Mth0158/dotfiles
zsh ~/code/Mth0158/dotfiles/install.sh
```

The script is safe to re-run. It:

- installs [Homebrew](https://brew.sh) and [oh-my-zsh](https://ohmyz.sh/) if they're missing
- symlinks every top-level file (except `*.sh`, `CLAUDE.md` and this README) to `~/.<name>`
- symlinks `config/**` to `~/.config/**` and `ssh/config` to `~/.ssh/config`
- installs the packages listed in the `Brewfile` and the zsh plugins
- installs the global Ruby and Node versions and the global npm CLIs (Cloudflare's `cf`) from `config/mise/config.toml` with `mise install`
- installs [GAM7](https://github.com/GAM-team/GAM) (Google Workspace admin CLI) to `~/bin/gam7` with its official installer
- symlinks `claude/CLAUDE.md` to `~/.claude/CLAUDE.md` and installs the Claude Code plugins listed in `install.sh` (Cloudflare)
- symlinks the Cursor settings and keybindings from `cursor/` and installs the extensions in `cursor/extensions.txt`
- sets up launch agents that start PostgreSQL 17 and Docker Desktop at login

Existing files are moved to `<name>.backup` before being replaced.

Then, once:

- put your SSH key at `~/.ssh/id_ed25519` (the script prints how to create one if it's missing) and run `ssh-add --apple-use-keychain ~/.ssh/id_ed25519` to save its passphrase in the Keychain
- add the key on GitHub as a signing key so commits show as Verified: `gh auth refresh -s admin:ssh_signing_key`, then `gh ssh-key add ~/.ssh/id_ed25519.pub --type signing`
- `cf auth login` to sign the Cloudflare CLI in (browser), and `/reload-plugins` in Claude Code
- GAM: its config in `~/.gam` (`gam.cfg`, service account key link) is per Workspace and not tracked; set it up from the project docs that use it
- optionally, `bash macos.sh` to apply the macOS preferences (keyboard, dark mode, Finder, Dock)

## Keeping it up to date

- **Homebrew:** after installing or removing a package, update the `Brewfile` by hand (`brew bundle check --global` and `brew bundle cleanup --global` show what differs)
- **Cursor:** settings and keybindings are symlinked, so changes made in Cursor land in this repo. After adding an extension, run `cursor --list-extensions > cursor/extensions.txt`
- **Global CLIs:** npm ones go in `config/mise/config.toml` as `"npm:<name>" = "<version>"` (not `npm install -g`, which ties them to one Node version); ones installed by script or tarball get an idempotent step in `install.sh`
- **Claude Code:** user instructions are `claude/CLAUDE.md` (symlinked); after adding a plugin, add it to the plugin list in `install.sh`
- **Rule:** any install or config change made on the machine lands here in the same task (agents are told so in `claude/CLAUDE.md`)
- **SSH:** private hosts go in `~/.ssh/config.local` (not tracked, since this repo is public)

## Toolset

- [oh-my-zsh](https://ohmyz.sh/)
- [Cursor](https://cursor.com/) as the Git and Bundler editor
- [git](https://git-scm.com/) with [delta](https://github.com/dandavison/delta) for diffs, commits signed with the SSH key
- Ruby and Node via [mise](https://mise.jdx.dev), switching on `.ruby-version`, `.node-version` and `.nvmrc`
- [Claude Code](https://claude.com/claude-code) with the Cloudflare plugin, and Cloudflare's [`cf` CLI](https://github.com/cloudflare/cf)
- [GAM7](https://github.com/GAM-team/GAM) for Google Workspace admin tasks (`gam`, not oh-my-zsh's `git am` alias)
- [fzf](https://github.com/junegunn/fzf) for Ctrl-R history search and [zoxide](https://github.com/ajeetdsouza/zoxide) for `z <dir>`
