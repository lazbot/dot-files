if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export CLICOLOR=1

if [ $(uname) = 'Darwin' ] ; then
    export SVN_EDITOR='subl -w'
    export EDITOR='subl -w'
    export EDITOR_DONT_WAIT='subl'
    export EDITOR_NEW_WINDOW='subl --new-window'
    export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Documents/Vagrant/"

    function add-my-key() { ssh-add -k ~/.ssh/arborwolf_rsa ~/.ssh/arborwolf_dsa; }

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    complete -o default -o nospace -F _gitk gitx

    alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

    export PATH=$PATH:/usr/local/sbin:~/bin:$HOME/.rvm/bin

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

export PS1='\n\t \u@$(uname -n):\[\e[34m\]\W\[\e[0m\]$(virtualenv_info) $(__git_ps1 "\[\e[32m\][%s $(get_sha)]\[\e[0m\]")\$ '

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

function f() { find . -name $1; }
function fd() { find $1 -name $2; }
function edit_name() { find . -name $1 | xargs $EDITOR_NEW_WINDOW; }
function edit_which() { $EDITOR_DONT_WAIT $(which $1); }
function flake_name() { find . -name $1 | xargs pyflakes; }

function fcd() {
    path=$(find . -name $1 | awk "BEGIN { getline; print }")
    cd $(dirname $path)
}

function cd_top() {
    git_dir=$(git rev-parse --git-dir)
    if [ -n "$git_dir" ]; then
        cd "$git_dir/../"
    fi
}

function get_dir() { printf "%s" $(pwd | sed "s:$HOME:~:"); }
function get_sha() { git rev-parse --short HEAD 2>/dev/null; }

function flake_committed() {
    commit=${1:-HEAD}
    git diff $commit ${commit}\^ --name-only --relative | grep '\.py$' | xargs pyflakes
}

function edit_committed() {
    commit=${1:-HEAD}
    git diff $commit ${commit}\^ --name-only --relative | xargs $EDITOR_NEW_WINDOW
}

alias dirty='git ls-files --modified --unmerged | awk '\''{ print $4 }'\'' | sort -u'
alias flake_dirty="dirty | grep '\.py$' | xargs pyflakes"
alias edit_dirty='dirty | xargs $EDITOR_NEW_WINDOW'

# alias push.='git push origin HEAD'
# alias push+='git push origin +HEAD'
# alias push-='git push origin :$(git rev-parse --symbolic-full-name HEAD)'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"

if [ $(which virtualenvwrapper.sh 2>/dev/null) ]; then
    source $(which virtualenvwrapper.sh)
fi
