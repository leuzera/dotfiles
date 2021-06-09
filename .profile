# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/Applications" ] ; then
    PATH="$HOME/Applications:$PATH"
fi

# Environment Variables. Set as needed;

# export NVM_DIR=""
# export GEM_HOME=""

# This will automagically find where 'javac' is installed
# export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")

# export ANDROID_HOME=""
# export ANDROID_AVD_HOME=""

# export REACT_EDITOR=code

# export FLUTTER_HOME=""

# export DOTNET_ROOT=""
# export DOTNET_HOME=""
# export DOTNET_CLI_TELEMETRY_OPTOUT=1

