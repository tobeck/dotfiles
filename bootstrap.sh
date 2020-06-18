#!/bin/zsh

git pull origin master

function doIt() {

    rsync \
	--exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "bootstrap.sh" \
    --exclude ".gitconfig" \
	--exclude "README.md" \
	--exclude ".gitignore" \
	--exclude "LICENSE-MIT.txt" \
	-av --no-perms . ~

    # Clone tmux-plugin-manager
    #git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

doIt
