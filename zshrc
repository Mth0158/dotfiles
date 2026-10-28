ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases history-substring-search zsh-autosuggestions zsh-syntax-highlighting ssh-agent)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed (to manage your Ruby versions)
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Node versions via n (https://github.com/tj/n)
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Auto-switch when .nvmrc or .node-version is present
autoload -U add-zsh-hook
load-node-version() {
  local version_file=""
  [[ -f .nvmrc ]] && version_file=".nvmrc"
  [[ -f .node-version ]] && version_file=".node-version"

  if [[ -n "$version_file" ]]; then
    local wanted current
    wanted="$(tr -d '[:space:]' < "$version_file")"
    wanted="${wanted#v}"

    command -v n >/dev/null || return

    current="$(node -v 2>/dev/null)"
    current="${current#v}"

    [[ "$current" == "$wanted" ]] || n "$wanted"
  fi
}
add-zsh-hook chpwd load-node-version
load-node-version

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}"
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
