[ -r /etc/zshrc ] && . /etc/zshrc

# profile
PROFILE_DEFAULT_ARCH=${PROFILE_DEFAULT_ARCH:-x86_64}
PROFILE_DEFAULT_USER=${PROFILE_DEFAULT_USER:-koba789}
PROFILE_DEFAULT_HOST=${PROFILE_DEFAULT_HOST:-koba789-pro}

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
PR_ARCH_CACHE=$(/usr/bin/uname -m)
if [ $PROFILE_DEFAULT_ARCH != $PR_ARCH_CACHE ]; then
    PR_ARCH="%F{green}${PR_ARCH_CACHE}%F{250}|%f"
else
    PR_ARCH=""
fi
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
    PROMPT="${PR_ARCH}${PROMPT}"
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
    orange    ) THEME_COLOR=166-172; THEME_COLOR_HEX='#d75f00-#d78700';;
    green     ) THEME_COLOR=28-35;   THEME_COLOR_HEX='#008700-#00af5f';;
    blue      ) THEME_COLOR=25-32;   THEME_COLOR_HEX='#005faf-#0087d7';;
    sky       ) THEME_COLOR=32-39;   THEME_COLOR_HEX='#0087d7-#00afff';;
    red       ) THEME_COLOR=124-160; THEME_COLOR_HEX='#af0000-#d70000';;
    raspberry ) THEME_COLOR=125-126; THEME_COLOR_HEX='#af005f-#af0087';;
    pink      ) THEME_COLOR=198-199; THEME_COLOR_HEX='#ff0087-#ff00af';;
    purple    ) THEME_COLOR=90-91;   THEME_COLOR_HEX='#870087-#8700af';;
    gray      ) THEME_COLOR=240-242; THEME_COLOR_HEX='#585858-#6c6c6c';;
esac

export COLOR_DARK=${THEME_COLOR%-*}
export COLOR_LIGHT=${THEME_COLOR#*-}
export COLOR_DARK_HEX=${THEME_COLOR_HEX%-*}
export COLOR_LIGHT_HEX=${THEME_COLOR_HEX#*-}

if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
