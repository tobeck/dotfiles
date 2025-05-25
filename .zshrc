# ----------------------------------------
# Powerlevel10k Instant Prompt (MUST BE FIRST)
# ----------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------
# Environment Setup
# ----------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

# ----------------------------------------
# Antigen Plugin Manager
# ----------------------------------------
ANTIGEN="$HOME/src/github.com/tobeck/dotfiles/antigen.zsh"
[[ -f "$ANTIGEN" ]] || curl -L git.io/antigen > "$ANTIGEN"
source "$ANTIGEN"

antigen use oh-my-zsh

# Load theme first for proper Powerlevel10k init
antigen theme romkatv/powerlevel10k

# Plugins
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Apply all antigen bundles
antigen apply

# ----------------------------------------
# Powerlevel10k Config (after antigen)
# ----------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ----------------------------------------
# Load Custom Dotfiles
# ----------------------------------------
for file in ~/.{path,exports,aliases}; do
  [[ -r "$file" ]] && source "$file"
done
[[ -f ~/.extra ]] && source ~/.extra

# ----------------------------------------
# Python: pyenv Setup
# ----------------------------------------
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# ----------------------------------------
# Node: NVM Lazy Load
# ----------------------------------------
autoload -U add-zsh-hook
load-nvm() {
  export NVM_DIR="$HOME/.nvm"
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
  [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  add-zsh-hook -d precmd load-nvm
}
add-zsh-hook precmd load-nvm

# ----------------------------------------
# Kubernetes: Completion + Alias
# ----------------------------------------
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias kver='kubectl version --short 2>/dev/null || echo "Kubernetes not available"'
fi

# ----------------------------------------
# Editor
# ----------------------------------------
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ----------------------------------------
# FZF (if installed)
# ----------------------------------------
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ----------------------------------------
# Conditional tmux Auto-launch (safe)
# ----------------------------------------
if command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" && "$TERM_PROGRAM" == "iTerm.app" ]]; then
  tmux attach -t default || tmux new -s default
fi
