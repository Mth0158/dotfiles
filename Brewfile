# Run `brew bundle` (install.sh does) to install everything below.
# `brew bundle check` lists what is missing, `brew bundle cleanup` what is not listed.

tap "anomalyco/tap"
tap "appsignal/appsignal-cli"
tap "heroku/brew"
tap "stripe/stripe-cli"

# Languages and version manager (mise handles Ruby and Node, see config/mise)
brew "mise"
brew "python@3.11"
brew "python-setuptools"

# Databases and services
brew "postgresql@17" # started by launchagents/local.postgresql@17.plist
brew "libpq", link: true
brew "redis", restart_service: :changed

# Docker (Docker Desktop itself is installed from docker.com)
brew "docker", link: false
brew "docker-buildx"
brew "docker-compose"

# Dev tools
brew "git"
brew "gh"
brew "jq"
brew "cloc"
brew "overmind"
brew "pygments"
brew "magika"
brew "libmagic"
brew "libsodium"
brew "hexedit"
brew "wget"
brew "lftp"

# Media, images and PDFs
brew "vips"
brew "pngquant"
brew "exiftool"
brew "media-info"
brew "qpdf"

# Networking
brew "nmap"
brew "unbound"
brew "wireguard-tools"

# Mail
brew "imapsync"
brew "isync"

# Misc
brew "open-mpi"
brew "scrcpy"

# Third-party CLIs
brew "anomalyco/tap/opencode", trusted: true
brew "appsignal/appsignal-cli/appsignal-cli", trusted: true
brew "heroku/brew/heroku", trusted: true
brew "stripe/stripe-cli/stripe", trusted: true

# Apps
cask "claude-code"
cask "dbeaver-community"
cask "gcloud-cli"
cask "ngrok"
cask "visual-studio-code"
