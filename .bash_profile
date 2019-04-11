#!/usr/bin/env bash
#
# Inspired by and borrowed from: https://github.com/keeganlow/dotfiles/blob/master/.bash_profile
#

if [[ -n "$TMUX" ]]; then
    bind '"\e[1~":"\eOH"'
    bind '"\e[4~":"\eOF"'
fi

# Add `~/bin` to the `$PATH`.
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.extra can be used for other settings you don’t want to commit
for file in ~/.{path,bash_prompt,exports,aliases,git-prompt.sh}; do
    [ -r "$file" ] && source "$file" && echo "sourced $file"
done
unset file

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# Prefer US English and use UTF-8.
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# if possible, add tab completion for many more commands.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export TERM='screen-256color'

set editing-mode vi
set keymap vi-command

#TODO: Move work related to its own files.
source "/Users/tobias.olsson2/src/stash.int.klarna.net/tx/tranzaxis-orchestration/team-tools/helpers"
source "/Users/tobias.olsson2/src/stash.int.klarna.net/tx/tranzaxis-orchestration/terraform/aws_tf_helpers"
source "/Users/tobias.olsson2/src/stash.int.klarna.net/tx/tranzaxis-explorer/explorer-helpers"

# Reload tmux configuration.
tmux source-file ~/.tmux.conf

export HOMEBREW_GITHUB_API_TOKEN=92509c2ea3fe8bc3514bd8e7cc79fb70e2b03d62
