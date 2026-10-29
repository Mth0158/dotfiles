ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Ruby and Node versions via mise (https://mise.jdx.dev), switching on
# .ruby-version, .node-version and .nvmrc (see config/mise/config.toml)
eval "$(mise activate zsh)"

# No relative dirs (./bin, ./node_modules/.bin) in PATH: any repo you cd into
# could shadow commands like `git` or `ls`. Use `bin/rails` and `npx` instead.
export PATH="/opt/homebrew/opt/postgresql@17/bin:${PATH}"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# History substring search on ↑/↓ (must be after zsh-syntax-highlighting)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor used by `bundle open <gem>`
export BUNDLER_EDITOR="cursor"

# Kamal registry token (GitHub, write:packages), stored in the macOS Keychain, never in this repo
export KAMAL_REGISTRY_PASSWORD="$(security find-generic-password -a "$USER" -s KAMAL_REGISTRY_PASSWORD -w 2>/dev/null)"

# fzf: Ctrl-R fuzzy history, Ctrl-T fuzzy file picker, Alt-C fuzzy cd
source <(fzf --zsh)

# zoxide: `z <part of a path>` jumps to a directory you've visited before (keep last)
eval "$(zoxide init zsh)"
