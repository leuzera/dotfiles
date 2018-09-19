#! /bin/zsh

if command -v nvim > /dev/null; then
    echo "Configuring neovim..."
    ln -sfi ~/.dotfiles/init.vim ~/.config/nvim/init.vim
    echo "\tdone."
else
    echo "Neovim not installed."
fi

if command -v zsh > /dev/null; then
    echo "Configuring zsh..."
    ln -sfi ~/.dotfiles/zshenv_home ${HOME}/.zshenv
    . ${HOME}/.zshenv

    if [[ ! -d ${ZDOTDIR} ]]; then
        mkdir ${ZDOTDIR}
    fi

    ln -sfi ~/.dotfiles/zshenv ${ZDOTDIR}/.zshenv
    ln -sfi ~/.dotfiles/zshrc ${ZDOTDIR:-$HOME}/.zshrc
    ln -sfi ~/.dotfiles/zsh_aliases ${ZDOTDIR:-$HOME}/.zsh_aliases
    echo "\tdone."
else
    echo "Zsh not installed."
fi

if command -v tmux > /dev/null; then
    echo "Configuring tmux..."
    ln -sfi ~/.dotfiles/tmux.conf ~/.tmux.conf
    echo "\tdone."
else
    echo "Tmux not installed."
fi

if command -v tint2 > /dev/null; then
    echo "Configuring tint2..."

    if [[ ! -d ~/.config/tint2 ]]; then
        mkdir ~/.config/tint2
    fi

    ln -sfi ./top.dracula.tint2rc ~/.config/tint2/top.dracula.tint2rc
    ln -sfi ./bottom.dracula.tint2rc ~/.config/tint2/bottom.dracula.tint2rc
else
    echo "Tint2 not installed."
fi

if command -v rofi > /dev/null; then
    echo "Configuring rofi..."

    if [[ ! -d ~/.config/rofi ]]; then
        mkdir ~/.config/rofi
    fi

    ln -sfi ./rofi.config ~/.config/rofi/config
    echo "\tdone."
else
    echo "Rofi not installed."
fi


if [[ -d ${ZDOTDIR:-$HOME}/.zprezto ]]; then
    echo "Configuring zpresto..."
    ln -sfi ~/.dotfiles/zprestorc ${ZDOTDIR:-$HOME}/.zpreztorc
    echo "\tdone."
else
    echo "ZPresto not installed."
fi
