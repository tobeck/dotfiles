# ----------------------------------------
# Base PATH setup
# ----------------------------------------
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

# ----------------------------------------
# Homebrew (if using Apple Silicon)
# ----------------------------------------
# Uncomment if you’re on M1/M2 and need it
# eval "$(/opt/homebrew/bin/brew shellenv)"

# ----------------------------------------
# pyenv (Python version manager)
# ----------------------------------------
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# ----------------------------------------
# NVM (Node version manager)
# ----------------------------------------
export NVM_DIR="$HOME/.nvm"
[[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
[[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
