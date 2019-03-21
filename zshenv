ZDOTDIR="${HOME}/.config/zsh"
fpath=("${ZDOTDIR}/user-functions" $fpath)
if [[ -d ${HOME}/zsh ]];
then
    . $ZDOTDIR/.zshenv
fi

NVM_DIR="$HOME/.nvm"
GEM_HOME=$HOME/.local/gems
BASE16_SHELL="$HOME/.config/base16-shell/"

# colored GCC warnings and errors
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
