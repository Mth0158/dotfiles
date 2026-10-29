#!/bin/zsh
# Set up this Mac from the dotfiles. Safe to re-run.
#
#   git clone https://github.com/Mth0158/dotfiles.git ~/code/Mth0158/dotfiles
#   zsh ~/code/Mth0158/dotfiles/install.sh
set -e
cd "${0:A:h}" # run from the repo folder, wherever it is called from
DOTFILES=$PWD

backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

# link <file in this repo> <target path>
link() {
  local target=$2
  mkdir -p "${target:h}"
  backup "$target"

  if [ ! -e "$target" ]; then
    echo "-----> Symlinking your new $target"
    ln -s "$DOTFILES/$1" "$target"
  fi
}

# Homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
  echo "-----> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh (--keep-zshrc: the zshrc from this repo is linked below)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "-----> Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Top-level files go to ~/.<name>
for name in *(.N); do
  if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ] && [ "$name" != 'CLAUDE.md' ]; then
    link "$name" "$HOME/.$name"
  fi
done

# Files in subfolders keep their path: config/mise/config.toml goes to
# ~/.config/mise/config.toml, ssh/config to ~/.ssh/config
for name in config/**/*(.N) ssh/config; do
  link "$name" "$HOME/.$name"
done

# Homebrew packages (Brewfile is also linked to ~/.Brewfile for `brew bundle --global`)
echo "-----> Installing Homebrew packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile" || echo "-----> Some Brewfile packages failed, see above"

# zsh plugins
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  if [ ! -d "$ZSH_PLUGINS_DIR/$plugin" ]; then
    echo "-----> Installing zsh plugin '$plugin'..."
    git clone "https://github.com/zsh-users/$plugin.git" "$ZSH_PLUGINS_DIR/$plugin"
  fi
done

# Global Ruby and Node versions (config/mise/config.toml); compiles Ruby the first time
echo "-----> Installing Ruby and Node with mise..."
(cd "$HOME" && mise install)

# Cursor settings, keybindings and extensions
CURSOR_USER="$HOME/Library/Application Support/Cursor/User"
for name in settings.json keybindings.json; do
  link "cursor/$name" "$CURSOR_USER/$name"
done
if command -v cursor >/dev/null; then
  installed=$(cursor --list-extensions)
  for extension in ${(f)"$(<cursor/extensions.txt)"}; do
    if ! grep -qix "$extension" <<< "$installed"; then
      echo "-----> Installing Cursor extension '$extension'..."
      cursor --install-extension "$extension" >/dev/null
    fi
  done
else
  echo "-----> Cursor not found, skipping extensions (install it from https://cursor.com, then re-run)"
fi

# PostgreSQL auto-start
if [[ -d "/opt/homebrew/opt/postgresql@17" ]]; then
  chmod +x "$DOTFILES/scripts/postgres-start.sh"
  PLIST_DEST="$HOME/Library/LaunchAgents/local.postgresql@17.plist"
  mkdir -p "${PLIST_DEST:h}"
  sed "s|DOTFILES|$DOTFILES|g" "$DOTFILES/launchagents/local.postgresql@17.plist" > "$PLIST_DEST"

  brew services stop postgresql@17 2>/dev/null || true
  launchctl bootout "gui/$(id -u)/local.postgresql@17" 2>/dev/null || true
  launchctl enable "gui/$(id -u)/local.postgresql@17"
  launchctl bootstrap "gui/$(id -u)" "$PLIST_DEST"

  echo "-----> PostgreSQL will start automatically at login"
fi

# Docker Desktop auto-start
if [[ -d "/Applications/Docker.app" ]]; then
  chmod +x "$DOTFILES/scripts/docker-start.sh"
  PLIST_DEST="$HOME/Library/LaunchAgents/local.docker-desktop.plist"
  mkdir -p "${PLIST_DEST:h}"
  sed "s|DOTFILES|$DOTFILES|g" "$DOTFILES/launchagents/local.docker-desktop.plist" > "$PLIST_DEST"

  launchctl bootout "gui/$(id -u)/local.docker-desktop" 2>/dev/null || true
  launchctl enable "gui/$(id -u)/local.docker-desktop"
  launchctl bootstrap "gui/$(id -u)" "$PLIST_DEST"

  echo "-----> Docker Desktop will start automatically at login"
else
  echo "-----> Docker Desktop not found, skipping auto-start (install it from https://docker.com, then re-run)"
fi

# Commits are signed with this key (see gitconfig), so it must exist
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo
  echo "⚠️  No SSH key at ~/.ssh/id_ed25519: git can't push or sign commits yet."
  echo "   ssh-keygen -t ed25519 -C \"$(git config user.email)\""
  echo "   ssh-add --apple-use-keychain ~/.ssh/id_ed25519"
  echo "   gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication"
  echo "   gh ssh-key add ~/.ssh/id_ed25519.pub --type signing"
  echo "   Then update config/git/allowed_signers with the new public key."
fi

echo
echo "👌 All set! Open a new terminal to load the new shell config."
echo "   Optional: bash macos.sh to apply the macOS preferences."
