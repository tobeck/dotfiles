# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

source $ZSH/oh-my-zsh.sh

# Install antigen a plugin manager for zsh
curl -L git.io/antigen > $HOME/src/github.com/tobeck/dotfiles/antigen.zsh
source $HOME/src/github.com/tobeck/dotfiles/antigen.zsh

antigen bundle git
antigen bundle zsh-autosuggestions 
antigen bundle zsh-syntax-highlighting

#antigen theme powerlevel10k/powerlevel10k

antigen apply


#TODO(): Remove when antigen tested
# Which plugins would you like to load?
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting)


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.extra can be used for other settings you don’t want to commit
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && source "$file" && echo "sourced $file"
done
unset file

# Install tmux tpm plugin manager
[ -d "~/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload tmux configuration.
tmux source-file ~/.tmux.conf

# pyenv Set PYENV_ROOT
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile

# Pyenv enable shims and autocomplete
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi'