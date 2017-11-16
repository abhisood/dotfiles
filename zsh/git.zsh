# git aliases
alias ga='git add'
alias gb='git branch'
#alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git s'
alias gss='git stash save'
alias gsp='git stash pop'
alias gmv='git mv'
alias grm='git rm'
alias grn='git-rename'
alias gl="git l"
alias gps="git pull --rebase && git su --init --recursive"
alias gpsc="git co master && gps"
alias gatc='git add Twitch.tv/Code/* && git st'
alias gch='git checkout HEAD~'

alias st='git st'
alias diff='git diff'
alias rhard='git reset --hard'
alias throw='git commit -m "throw away"'
alias fix='git commit -m "fix requested changes"'

# alias git-amend='git commit --amend -C HEAD'
alias gitundo='git reset --soft HEAD~1'
alias git-count='git shortlog -sn'
alias git-undopush="git push -f origin HEAD^:master"
alias cpbr="git rev-parse --abbrev-ref HEAD | pbcopy"
# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

alias sub-pull='git submodule foreach git pull origin master'

function give-credit() {
    git commit --amend --author $1 <$2> -C HEAD
}

function gitc() {
    git co $1 && gps
}


# a simple git rename file function
# git does not track case-sensitive changes to a filename.
function git-rename() {
    git mv $1 "${2}-"
    git mv "${2}-" $2
}

function g() {
    if [[ $# > 0 ]]; then
        # if there are arguments, send them to git
        git $@
    else
        # otherwise, run git status
        git s
    fi
}
