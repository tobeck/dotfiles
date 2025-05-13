# ----------------------------------------
# Powerlevel10k Instant Prompt — MUST BE FIRST
# ----------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------
# Basic Environment
# ----------------------------------------
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# ----------------------------------------
# Antigen + Powerlevel10k Setup
# ----------------------------------------
ANTIGEN="$HOME/src/github.com/tobeck/dotfiles/antigen.zsh"
[[ -f "$ANTIGEN" ]] || curl -L git.io/antigen > "$ANTIGEN"
source "$ANTIGEN"

antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k

# Plugins
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Apply Antigen config
antigen apply

# ----------------------------------------
# Powerlevel10k Config (after antigen apply)
# ----------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ----------------------------------------
# Dotfile Sourcing (safe)
# ----------------------------------------
for file in ~/.{path,exports,aliases}; do
  [[ -r "$file" && -z "$DOTFILES_ALREADY_LOADED" ]] && source "$file"
done
DOTFILES_ALREADY_LOADED=1

# ----------------------------------------
# Lazy-load NVM
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
# Kubernetes Completion + Alias (no slow check)
# ----------------------------------------
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias kver='kubectl version --short 2>/dev/null || echo "Kubernetes not available"'
fi

# ----------------------------------------
# Editor Pref
# ----------------------------------------
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ----------------------------------------
# Conditional tmux start
# ----------------------------------------
if [[ -n "$ITERM_PROFILE" && -z "$TMUX" && "$TERM_PROGRAM" != "vscode" ]]; then
  exec tmux
fi

# ----------------------------------------
# tmux Plugin Manager
# ----------------------------------------
TPM_DIR="$HOME/.tmux/plugins/tpm"
[[ -d "$TPM_DIR" ]] || git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"

if [[ -n "$TMUX" ]]; then
  tmux source-file ~/.tmux.conf
fi
