# machine
source "${HOME}/.zsh/machine.zsh"

# theme

if [ -z $THEME_COLOR ]; then
    # default is raspberry
    THEME_COLOR=raspberry
fi

case $THEME_COLOR in
    orange    ) THEME_COLOR=166-172;;
    green     ) THEME_COLOR=28-35;;
    blue      ) THEME_COLOR=25-32;;
    sky       ) THEME_COLOR=32-39;;
    red       ) THEME_COLOR=124-160;;
    raspberry ) THEME_COLOR=125-126;;
    pink      ) THEME_COLOR=198-199;;
    purple    ) THEME_COLOR=90-91;;
    gray      ) THEME_COLOR=240-242;;
esac

export COLOR_DARK=${THEME_COLOR%-*}
export COLOR_LIGHT=${THEME_COLOR#*-}

# profile
PROFILE_DEFAULT_USER=koba789
PROFILE_DEFAULT_HOST=koba789-pro

# color
autoload colors
colors

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '#%b'
zstyle ':vcs_info:*' actionformats '#%b|%a'
PR_USER="%U%n%u%F{250}@%f"
PR_COLON="%F{250}:%f"
PR_HOST="%m${PR_COLON}"
PR_HOST_H="%B%K{$COLOR_DARK}%m%k%b${PR_COLON}"
precmd() {
    LANG=en_US.UTF-8 vcs_info
    PROMPT="%~%F{green}${vcs_info_msg_0_}%F{$COLOR_DARK} %(!.#.$)%f "
    if [ $PROFILE_DEFAULT_HOST != $(hostname -s) ]; then
        PROMPT="${PR_HOST_H}${PROMPT}"
        if [ $PROFILE_DEFAULT_USER != $(whoami) ]; then
            PROMPT="${PR_USER}${PROMPT}"
        fi
    elif [ $PROFILE_DEFAULT_USER != $(whoami) ]; then
        PROMPT="${PR_USER}${PR_HOST}${PROMPT}"
    fi
}

# completion
autoload -U compinit
compinit
autoload bashcompinit
bashcompinit

# npm completion
source "${HOME}/.zsh/npm-completion.bash"

zstyle ':completion:*:default' menu select=1

setopt auto_pushd
setopt auto_cd
setopt nolistbeep

# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history

# editor
export EDITOR='emacs'

# key map
bindkey -e

# PATH
export PATH="${PATH}:/usr/local/bin:/usr/local/sbin"
export PATH="${HOME}/bin:${PATH}"

# rbenv
eval "$(rbenv init -)"

# ls aliases
alias l="ls"
alias la="ls"
alias ll="ls -la"
alias sl="ls"

# git aliases
alias gps="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gmg="git merge"
alias gcp="git cherry-pick"
alias glg="git log"

# pkgconfig
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"

# make sandbox
MKSDBX="${HOME}/src/mksdbx/mksdbx"
if [ -f $MKSDBX ]; then
    source $MKSDBX
fi
