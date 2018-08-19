#! /bin/zsh

if [command -v nvim]
then
    sudo ln -sfi ~/.dotfiles/init.vim ~/.config/nvim/init.vim
fi

if [command -v zsh]
then
    if [[ -v $ZDOTDIR ]]
    then
        mkdir ~/.config/zsh
        ZDOTDIR=~/.config/zsh
    fi
    mkdir ${ZDOTDIR:-$HOME}/.zprompts && fpath=( "${ZDOTDIR:-$HOME}/.zprompts" $fpath )

    sudo ln -sfi ~/.dotfiles/zshrc ${ZDOTDIR:-$HOME}/.zshrc
    sudo ln -sfi ~/.dotfiles/zsh_aliases ${ZDOTDIR:-$HOME}/.zsh_aliases
    wget https://raw.githubusercontent.com/dracula/zsh/22058079469b74af07f1f4984df505f9b5156c1f/dracula.zsh-theme -O ${ZDOTDIR:-$HOME}/.zprompts/dracula.zsh_theme
fi

if [command -v tmux]
then
    sudo ln -sfi ~/.dotfiles/tmux.conf ~/.tmux.conf
fi

if [[ -d ${ZDOTDIR:-$HOME}/.zprezto ]]
then
    sudo ln -sfi ~/.dotfiles/zprestorc ~/.zpreztorc
fi
