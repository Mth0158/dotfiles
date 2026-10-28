#!/bin/zsh

backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ] && [ "$name" != 'CLAUDE.md' ]; then
      backup $target

      if [ ! -e "$target" ]; then
        echo "-----> Symlinking your new $target"
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done

# zsh plugins
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  if [ ! -d "$ZSH_PLUGINS_DIR/$plugin" ]; then
    echo "-----> Installing zsh plugin '$plugin'..."
    git clone "https://github.com/zsh-users/$plugin.git" "$ZSH_PLUGINS_DIR/$plugin"
  fi
done

setopt nocasematch

# PostgreSQL auto-start (macOS)
if [[ `uname` =~ "darwin" ]] && [[ -d "/opt/homebrew/opt/postgresql@17" ]]; then
  chmod +x "$CURRENT_DIR/scripts/postgres-start.sh"
  PLIST_DEST="$HOME/Library/LaunchAgents/local.postgresql@17.plist"
  sed "s|DOTFILES|$CURRENT_DIR|g" "$CURRENT_DIR/launchagents/local.postgresql@17.plist" > "$PLIST_DEST"

  brew services stop postgresql@17 2>/dev/null || true
  launchctl bootout "gui/$(id -u)/local.postgresql@17" 2>/dev/null || true
  launchctl enable "gui/$(id -u)/local.postgresql@17"
  launchctl bootstrap "gui/$(id -u)" "$PLIST_DEST"

  echo "-----> PostgreSQL will start automatically at login"
fi

# Docker Desktop auto-start (macOS)
if [[ `uname` =~ "darwin" ]] && [[ -d "/Applications/Docker.app" ]]; then
  chmod +x "$CURRENT_DIR/scripts/docker-start.sh"
  PLIST_DEST="$HOME/Library/LaunchAgents/local.docker-desktop.plist"
  sed "s|DOTFILES|$CURRENT_DIR|g" "$CURRENT_DIR/launchagents/local.docker-desktop.plist" > "$PLIST_DEST"

  launchctl bootout "gui/$(id -u)/local.docker-desktop" 2>/dev/null || true
  launchctl enable "gui/$(id -u)/local.docker-desktop"
  launchctl bootstrap "gui/$(id -u)" "$PLIST_DEST"

  echo "-----> Docker Desktop will start automatically at login"
fi

zsh ~/.zshrc

echo "👌  All set!"
