ZDOTDIR="${HOME}/.config/zsh"

fpath=("${ZDOTDIR}/user-functions" $fpath)

if [[ -d ${HOME}/zsh ]];
then
    . $ZDOTDIR/.zshenv
fi

NVM_DIR="$HOME/.nvm"
GEM_HOME=$HOME/.local/gems

JAVA_HOME="/usr/lib/jvm/default"
ANDROID_HOME="$HOME/.local/Android/Sdk"

# colored GCC warnings and errors
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Setting PATH
typeset -U path

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  path=($HOME/bin $path[@])
fi
if [ -d "$HOME/.local/bin" ] ; then
  path=($HOME/.local/bin $path[@])
fi

path=($JAVA_HOME/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $path[@])
