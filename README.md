My personal dotfiles, originally forked from [Le Wagon's dotfiles](https://github.com/lewagon/dotfiles).

## Install

```bash
zsh install.sh
```

Install [Homebrew](https://brew.sh) and [oh-my-zsh](https://ohmyz.sh/) first. The script then:

- symlinks every top-level file (except `*.sh`, `CLAUDE.md` and this README) to `~/.<name>`
- symlinks `config/**` to `~/.config/**` and `ssh/config` to `~/.ssh/config`
- installs the packages listed in the `Brewfile`
- installs the zsh plugins
- on macOS, sets up launch agents that start PostgreSQL 17 and Docker Desktop at login

After installing or removing a Homebrew package, update the `Brewfile` by hand (`brew bundle check --global` and `brew bundle cleanup --global` show what differs).

## Toolset

- [oh-my-zsh](https://ohmyz.sh/)
- [Cursor](https://cursor.com/) as the Git and Bundler editor
- [git](https://git-scm.com/)
- Ruby via [`rbenv`](https://github.com/rbenv/rbenv)
- Node via [`n`](https://github.com/tj/n), auto-switching on `.nvmrc` / `.node-version`
