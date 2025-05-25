#!/bin/zsh

set -e  # Exit immediately if any command fails

echo "🔄 Pulling latest changes from Git..."
git pull origin master || {
  echo "❌ Failed to pull from Git."
  exit 1
}

function install_dependencies() {
  echo "📦 Checking system dependencies..."

  # macOS: Install with Homebrew
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # Install Homebrew if not installed
    if ! command -v brew >/dev/null 2>&1; then
      echo "🍺 Homebrew not found. Installing..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null

      # ✅ Add Homebrew to PATH right after install
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "📥 Installing tools via Homebrew..."
    brew install \
      tmux \
      reattach-to-user-namespace \
      zsh \
      fzf \
      bat \
      ripgrep \
      fd \
      zoxide \
      eza \
      poetry

    # Optional: Install fzf keybindings and completions
    if [[ -f /opt/homebrew/opt/fzf/install ]]; then
      /opt/homebrew/opt/fzf/install --no-update-rc --key-bindings --completion
    fi
  else
    echo "🔧 Linux or unsupported platform. Please install these tools manually:"
    echo "  - zsh, tmux, fzf, bat, ripgrep, fd, zoxide, exa, poetry"
  fi
}

function doIt() {
  echo "⚙️  Syncing dotfiles..."

  rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "bootstrap.sh" \
        --exclude ".gitconfig" \
        --exclude "README.md" \
        --exclude ".gitignore" \
        --exclude "LICENSE-MIT.txt" \
        -av --no-perms . ~

  echo "✅ Dotfiles copied to home directory."

  # Install TPM if needed
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "📦 Installing tmux plugin manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    echo "✅ TPM already installed."
  fi

  echo ""
  echo "🚀 Done. Restart your terminal or run: source ~/.zshrc"
}

# Prompt before continuing
read "response?This may overwrite existing files in your home directory. Continue? (y/N) "
if [[ "$response" =~ ^[Yy]$ ]]; then
  install_dependencies
  doIt
else
  echo "❌ Aborted."
fi
