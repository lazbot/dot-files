if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export CLICOLOR=1

if [ $(uname) = 'Darwin' ] ; then

    if [ "${SSH_CONNECTION}" ] ; then
        export SVN_EDITOR='vim'
        export EDITOR='vim'
        export EDITOR_DONT_WAIT='vim'
        export EDITOR_NEW_WINDOW='vim'

    else
        export SVN_EDITOR='subl -w'
        export EDITOR='subl -w'
        export EDITOR_DONT_WAIT='subl'
        export EDITOR_NEW_WINDOW='subl --new-window'
        export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Documents/Vagrant/"

        complete -o default -o nospace -F _gitk gitx

        alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
    fi

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    export PATH=$PATH:~/bin:~/.rvm/bin
    export GOPATH=/Users/wolf/Work/go

    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
else
    alias ls='ls --color=always'
    export SVN_EDITOR='vim'
    export EDITOR='vim'
    export EDITOR_DONT_WAIT='vim'
    export EDITOR_NEW_WINDOW='vim'

    if [ -f ~/.git-completion.bash ] ; then
        source ~/.git-completion.bash
    fi
    if [ -f ~/.git-prompt.sh ] ; then
        source ~/.git-prompt.sh
    fi

    function fx() {
        find . -name $1 | xargs ls -l --color=always
    }

    export PATH=$PATH:/usr/local/sbin:~/bin

    if [[ -d "/arbos-tmp" && -n $SSH_AUTH_SOCK ]]; then
        if [[ ! $SSH_AUTH_SOCK = /arbos-tmp* ]]; then
            SSH_AUTH_SOCK=$(echo $SSH_AUTH_SOCK | sed 's/tmp/arbos-tmp/')
        fi
    fi
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo ' ('$(basename $VIRTUAL_ENV)')'
}

function tip() {
    git rev-parse --short HEAD 2>/dev/null
}

# used to reattach ssh forwarding to "stale" tmux sessions
# http://justinchouinard.com/blog/2010/04/10/fix-stale-ssh-environment-variables-in-gnu-screen-and-tmux/
function refresh_ssh() {
    if [[ -n $TMUX ]]; then
        NEW_SSH_AUTH_SOCK=$(tmux showenv | grep ^SSH_AUTH_SOCK | cut -d = -f 2)
        if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
            SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
        fi
    fi
}

export PS1='\n\t \u@$(uname -n):\[\e[34m\]\W\[\e[0m\]$(virtualenv_info) $(__git_ps1 "\[\e[32m\][%s $(tip)]\[\e[0m\]")\$ '

export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="&:ls:[bf]g:exit:history:..:cdgit:make:git pull:git commit"
shopt -s histappend cdspell

alias ll='ls -FTGalh'
alias ..='cd ..'
alias ...='cd ../..'

function did() { history | grep $1; }

bind '"\t":menu-complete'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

function f() {
    find . -name $1
}

function fcd() {
    path=$(find . -name $1 | awk "BEGIN { getline; print }")
    cd $(dirname $path)
}

function cdtop() {
    git_dir=$(git rev-parse --git-dir)
    if [ -n "$git_dir" ]; then
        cd "$git_dir/../"
    fi
}

function since_commit() {
    commit=${1:-HEAD}
    git diff $commit --name-only --relative
}

function in_commit() {
    commit=${1:-HEAD}
    git diff $commit ${commit}\^ --name-only --relative
}

function dirty() {
    git ls-files --modified --unmerged | awk '{ print $4 }' | sort -u
}

function pyflakes_name() {
    find . -name $1 | xargs pyflakes
}

function pyflakes_since() {
    since_commit $1 | grep '\.py$' | xargs pyflakes
}

function pyflakes_commit() {
    in_commit $1 | grep '\.py$' | xargs pyflakes
}

function pyflakes_dirty() {
    dirty | grep '\.py$' | xargs pyflakes
}

function pylint_since() {
    since_commit $1 | grep '\.py$' | xargs pylint
}

function pylint_commit() {
    in_commit $1 | grep '\.py$' | xargs pylint
}

function pylint_dirty() {
    dirty | grep '\.py$' | xargs pylint
}

function jshint_name() {
    find . -name $1 | xargs jshint
}

function jshint_since() {
    since_commit $1 | grep '\.js$' | xargs jshint
}

function jshint_commit() {
    in_commit $1 | grep '\.js$' | xargs jshint
}

function jshint_dirty() {
    dirty | grep '\.js$' | xargs jshint
}

function edit_name() {
    $EDITOR_NEW_WINDOW $(find . -name $1 -type f)
}

function edit_which() {
    $EDITOR_NEW_WINDOW $(which $1)
}

function edit_since() {
    $EDITOR_NEW_WINDOW $(since_commit $1)
}

function edit_commit() {
    $EDITOR_NEW_WINDOW $(in_commit $1)
}

function edit_dirty() {
    $EDITOR_NEW_WINDOW $(dirty)
}

function add_dirty() {
    dirty | xargs git add
}

# alias push.='git push origin HEAD'
# alias push+='git push origin +HEAD'
# alias push-='git push origin :$(git rev-parse --symbolic-full-name HEAD)'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"

#if [ $(which virtualenvwrapper.sh 2>/dev/null) ]; then
#    source $(which virtualenvwrapper.sh)
#fi
