ZDOTDIR="${HOME}/.config/zsh"

fpath=("${ZDOTDIR}/user-functions" $fpath)

if [[ -d ${HOME}/zsh ]]; then
    . $ZDOTDIR/.zshenv
fi

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

if [ -d "$JAVA_HOME" ]; then
  path=($JAVA_HOME/bin $path[@])
fi

# set PATH to include Android SDK tools if it exists
if [ -d "$ANDROID_HOME" ]; then
  path=($ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/emulator $path[@])
fi

# set PATH to include Flutter binaries if it exists
if [ -d "$FLUTTER_HOME" ]; then
  path=($FLUTTER_HOME/bin $path[@])
fi

# set PATH to DOTNET if it exists
if [ -d "$DOTNET_HOME" ]; then
  path=($DOTNET_HOME $path[@])
fi
