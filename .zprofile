# ----------------------------------------
# Base PATH
# ----------------------------------------
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

# ----------------------------------------
# Homebrew (Apple Silicon only)
# ----------------------------------------
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ----------------------------------------
# pyenv (PATH and early init for login shells)
# ----------------------------------------
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# ----------------------------------------
# Poetry (optional, depends on install method)
# ----------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ----------------------------------------
# NVM path (shell loads it lazily via zshrc)
# ----------------------------------------
export NVM_DIR="$HOME/.nvm"
