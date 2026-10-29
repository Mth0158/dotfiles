# Homebrew (PATH, MANPATH, HOMEBREW_* env vars)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load the SSH key from the Keychain into the macOS agent, so git can sign
# commits (and apps like GitHub Desktop can push) right after a restart
ssh-add -l >/dev/null 2>&1 || ssh-add --apple-load-keychain -q 2>/dev/null
