#zmodload zsh/zprof && zprof

# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt no_flow_control
setopt hist_no_store

# PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"

source $ZDOTDIR/.zshenv.local
