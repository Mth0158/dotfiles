My personal dotfiles, originally forked from [Le Wagon's dotfiles](https://github.com/lewagon/dotfiles).

## Install

```bash
zsh install.sh
```

This symlinks every top-level file (except `*.sh` and this README) to `~/.<name>`, installs the zsh plugins, and on macOS sets up launch agents that start PostgreSQL 17 and Docker Desktop at login.

## Toolset

- [oh-my-zsh](https://ohmyz.sh/)
- [Cursor](https://cursor.com/) as the Git and Bundler editor
- [git](https://git-scm.com/)
- Ruby via [`rbenv`](https://github.com/rbenv/rbenv)
- Node via [`n`](https://github.com/tj/n), auto-switching on `.nvmrc` / `.node-version`
