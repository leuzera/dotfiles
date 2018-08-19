#! /bin/zsh

if [command -v nvim]
then
    echo "Configuring neovim..."
    sudo ln -sfi ~/.dotfiles/init.vim ~/.config/nvim/init.vim
    echo "\tdone."
else
    echo "Neovim not installed."
fi

if [command -v zsh]
then
    echo "Configuring zsh..."
    sudo ln -sfi ~/.dotfiles/zshenv ${HOME}/.zshenv
    . ${HOME}/.zshenv

    sudo ln -sfi ~/.dotfiles/zshrc ${ZDOTDIR:-$HOME}/.zshrc
    sudo ln -sfi ~/.dotfiles/zsh_aliases ${ZDOTDIR:-$HOME}/.zsh_aliases
    echo "\tdone."
else
    echo "Zsh not installed."
fi

if [command -v tmux]
then
    echo "Configuring tmux..."
    sudo ln -sfi ~/.dotfiles/tmux.conf ~/.tmux.conf
    echo "\tdone."
else
    echo "Tmux not installed."
fi

if [[ -d ${ZDOTDIR:-$HOME}/.zprezto ]]
then
    echo "Configuring zpresto..."
    sudo ln -sfi ~/.dotfiles/zprestorc ~/.zpreztorc
    echo "\tdone."
else
    echo "ZPresto not installed."
fi
