[ -r /etc/zshrc ] && . /etc/zshrc

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
precmd() {
    local PR_HOST_H="%B%K{$COLOR_DARK}%m%k%b${PR_COLON}"
    LANG=en_US.UTF-8 vcs_info
    if test -z "`jobs`"; then
        local PR_CWD="%~"
    else
        local PR_CWD="%U%~%u"
    fi
    PROMPT="%F{blue}${PR_CWD}%F{green}${vcs_info_msg_0_}%F{250}%(!.#.$)%f "
    if [ $PROFILE_DEFAULT_HOST != ${HOST%.*} ]; then
        PROMPT="${PR_HOST_H}${PROMPT}"
        if [ $PROFILE_DEFAULT_USER != $USER ]; then
            PROMPT="${PR_USER}${PROMPT}"
        fi
    elif [ $PROFILE_DEFAULT_USER != $USER ]; then
        PROMPT="${PR_USER}${PR_HOST}${PROMPT}"
    fi
}

# completion
autoload -U compinit
compinit -u
zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*:default' menu select=1

setopt auto_pushd
setopt auto_cd
setopt nolistbeep

# editor
export EDITOR=emacs

# report spent time of long running command automatically
export REPORTTIME=1

# local config
source ${HOME}/.zsh/.zshrc.local

# theme

# default is raspberry
THEME_COLOR=${THEME_COLOR:-raspberry}

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
PROFILE_DEFAULT_USER=${PROFILE_DEFAULT_USER:-koba789}
PROFILE_DEFAULT_HOST=${PROFILE_DEFAULT_HOST:-koba789-pro}

if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
