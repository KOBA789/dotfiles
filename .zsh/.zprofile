# ls aliases
alias ls='ls --color=auto'
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

# other aliases
alias fg=" fg"
alias bk=" popd"

# key map
bindkey -e

source $ZDOTDIR/.zprofile.local
