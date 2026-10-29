#!/bin/bash
# macOS preferences. Safe to re-run: it only sets the values below.
# Some changes (key repeat, dark mode) take effect after logging out and back in.
#
#   bash macos.sh
#
# Active settings match this Mac. Uncomment the suggestions you want.

# Keyboard: fastest key repeat, short delay before it starts
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Appearance: dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# Finder: list view by default
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

# Dock: larger icons
defaults write com.apple.dock tilesize -int 81

# Finder: show hidden files, all file extensions, path bar and status bar
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Don't write .DS_Store files on network and USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Screenshots: save to ~/Screenshots as PNG
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# --- Suggestions (uncomment to enable) ---------------------------------------

# Finder: search the current folder by default, keep folders on top
# defaults write com.apple.finder FXDefaultSearchScope -string SCcf
# defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Keyboard: repeat keys when held instead of showing the accent picker
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Typing: no smart quotes or dashes (they break code pasted into chats and docs)
# defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Dock: don't show recent apps
# defaults write com.apple.dock show-recents -bool false

# Restart the apps whose preferences changed
killall Finder Dock SystemUIServer 2>/dev/null
echo "👌 macOS preferences applied (log out and back in for keyboard and appearance)"
