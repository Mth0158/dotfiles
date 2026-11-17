When interacting with Cloudflare, use the cf CLI unless the project has a Wrangler configuration file.

## Machine setup lives in the dotfiles

`~/code/Mth0158/dotfiles` rebuilds this Mac (`install.sh`). When a task installs, removes, upgrades or reconfigures something on the machine rather than in a project, update the dotfiles in the same task, following their README § Keeping it up to date:

- Homebrew package or cask → `Brewfile`
- global npm CLI, Ruby or Node version → `config/mise/config.toml` (never `npm install -g`)
- CLI installed by script or tarball (GAM…) → an idempotent step in `install.sh`
- Claude Code plugin or marketplace → the plugin list in `install.sh`; these user instructions → `claude/CLAUDE.md`
- shell PATH, alias or env var → `zshrc` / `aliases`
- a manual step (sign-in, per-account config) → README § Then, once

The repo is public: no secret, token, key path content, account id or client name in it. Point at where the value lives instead. Do not commit there unless asked.
