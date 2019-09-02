#! /bin/zsh

source /etc/os-release

PKG_MNG="" # package management utility
CMD_INSTALL="" # command to install program

if $ID = "manjaro"; then 
  PKG_MNG="pacman"
  CMD_INSTALL="pacman -S"
elif $ID = "ubuntu"; then
  PKG_MNG="apt"
  CMD_INSTALL="${PKG_MNG} -y install"
fi

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    ${CMD_INSTALL} $1
  else
    echo "Already installed: ${1}"
  fi
}

ln -sf $(readlink -f ./zshenv) ${HOME}/.zshenv && . ${HOME}/.zshenv
ln -sf $(readlink -f ./config/nvim) ${HOME}/.config/nvim
ln -sf $(readlink -f ./config/zsh) ${ZDOTDIR}
ln -sf $(readlink -f ./config/alacritty) ${HOME}/.config/alacritty
ln -sf $(readlink -f ./tmux.conf) ${HOME}/.tmux.conf
ln -sf $(readlink -f ./config/tint2) ${HOME}/.config/tint2

