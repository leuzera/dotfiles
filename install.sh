#! /bin/zsh

source /etc/os-release

ln -sf $(readlink -f ./zshenv) ${HOME}/.zshenv && . ${HOME}/.zshenv
ln -sf $(readlink -f ./config/nvim) ${HOME}/.config/nvim
ln -sf $(readlink -f ./config/zsh) ${ZDOTDIR}
ln -sf $(readlink -f ./config/alacritty) ${HOME}/.config/alacritty
ln -sf $(readlink -f ./tmux.conf) ${HOME}/.tmux.conf
ln -sf $(readlink -f ./config/tint2) ${HOME}/.config/tint2

