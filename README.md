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

Then, once:

- `mise install` installs the global Ruby and Node versions from `config/mise/config.toml`

## Toolset

- [oh-my-zsh](https://ohmyz.sh/)
- [Cursor](https://cursor.com/) as the Git and Bundler editor
- [git](https://git-scm.com/)
- Ruby and Node via [mise](https://mise.jdx.dev), switching on `.ruby-version`, `.node-version` and `.nvmrc`
- [fzf](https://github.com/junegunn/fzf) for Ctrl-R history search and [zoxide](https://github.com/ajeetdsouza/zoxide) for `z <dir>`
