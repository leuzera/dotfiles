#! /bin/zsh

############ Neovim ###################
if command -v nvim > /dev/null; then
    echo "Configuring neovim..."
    ln -sfi $(readlink -f ./config/nvim) ${HOME}/.config/nvim
    echo "\tdone."
else
    echo "Neovim not installed."
fi

################ Zsh ##################
if command -v zsh > /dev/null; then
    echo "Configuring zsh..."
    ln -sf $(readlink -f ./zshenv) ${HOME}/.zshenv
    . ${HOME}/.zshenv

    ln -sf $(readlink -f ./config/zsh) ${ZDOTDIR}
    echo "\tdone."
else
    echo "Zsh not installed."
fi

############### Alacritty ###############
if command -v alacritty > /dev/null; then
    echo "Configuring Alacritty..."
    ln -sf $(readlink -f ./config/alacritty) ${HOME}/.config/alacritty
    echo "\tdone."
else
    echo "Alacritty not installed."
fi

############### Tmux ####################
if command -v tmux > /dev/null; then
    echo "Configuring tmux..."
    ln -sf $(readlink -f ./tmux.conf) ${HOME}/.tmux.conf
    echo "\tdone."
else
    echo "Tmux not installed."
fi

############# Tint2 #####################
if command -v tint2 > /dev/null; then
    echo "Configuring tint2..."

    ln -sf $(readlink -f ./config/tint2) ${HOME}/.config/tint2

else
    echo "Tint2 not installed."
fi

