# Basic zsh config.
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"

# Set up the prompt

autoload -Uz promptinit
promptinit

if [ ! -f "${ZDOTDIR}/powerlevel10k/powerlevel10k.zsh-theme" ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZDOTDIR}/powerlevel10k
fi
if [ ! -f "${ZDOTDIR}/purepower" ]; then
    curl -fsSL https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower -o ${ZDOTDIR}/purepower
fi

# prompt theme
if [ -f "${ZDOTDIR}/powerlevel10k/powerlevel10k.zsh-theme" ]; then
    source ${ZDOTDIR}/powerlevel10k/powerlevel10k.zsh-theme
    if [ -f "${ZDOTDIR}/purepower" ]; then
        source ${ZDOTDIR}/purepower
    fi
else
    prompt pure
fi

setopt histignorealldups sharehistory

# using vi mode
# bindkey -v

# Only the past commands matching the current line up to the current cursor
# position will be shown
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Base16 Shell
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.
if [[ -f ${ZDOTDIR:-$HOME}/.zsh_aliases ]]; then
    . ${ZDOTDIR:-$HOME}/.zsh_aliases
fi

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/leonardo/.local/google-cloud-sdk/path.zsh.inc' ]; then
    . '/home/leonardo/.local/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/leonardo/.local/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/home/leonardo/.local/google-cloud-sdk/completion.zsh.inc';
fi

# Anaconda
if [ -f '/home/leonardo/.local/anaconda3/etc/profile.d/conda.sh' ]; then
    . '/home/leonardo/.local/anaconda3/etc/profile.d/conda.sh'
fi
