if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export CLICOLOR=1

if [ $(uname) = 'Darwin' ] ; then
    export SVN_EDITOR='subl -w'
    export EDITOR='subl -w'
    export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Documents/Vagrant/"

    add-my-key () { ssh-add -k ~/.ssh/arborwolf_rsa ~/.ssh/arborwolf_dsa; }

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

    export PATH=$PATH:/usr/local/sbin:~/bin:$HOME/.rvm/bin

    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
else
    alias ls='ls --color=always'
    export SVN_EDITOR='vim'
    export EDITOR='vim'

    add-my-key () { ssh-add ~/.ssh/arborwolf_rsa ~/.ssh/arborwolf_dsa; }

    if [ -f ~/.git-completion.bash ] ; then
        source ~/.git-completion.bash
    fi
    if [ -f ~/.git-prompt.sh ] ; then
        source ~/.git-prompt.sh
    fi

    export PATH=$PATH:/usr/local/sbin:~/bin

    if [[ -d "/arbos-tmp" && -n $SSH_AUTH_SOCK ]]; then
        if [[ ! $SSH_AUTH_SOCK = /arbos-tmp* ]]; then
            SSH_AUTH_SOCK=$(echo $SSH_AUTH_SOCK | sed 's/tmp/arbos-tmp/')
        fi
    fi
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ' ('$(basename $VIRTUAL_ENV)')'
}

export PS1='\n\t \u@$(uname -n):\[\e[34m\]\W\[\e[0m\]$(virtualenv_info) $(__git_ps1 "\[\e[32m\][%s $(get_sha)]\[\e[0m\]")\$ '

export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="&:ls:[bf]g:exit:history:..:cdgit:make:git pull:git commit"
shopt -s histappend cdspell

alias ll='ls -alh'
alias ..='cd ..'
alias ...='cd ../..'

did () { history | grep $1; }

bind '"\t":menu-complete'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

f () { find . -name $1; }
fd () { find $1 -name $2; }
sbn () { find . -name $1 | xargs subl --new-window; }
sbw () { subl $(which $1); }
flaken () { find . -name $1 | xargs pyflakes; }

get_dir () { printf "%s" $(pwd | sed "s:$HOME:~:"); }
get_sha () { git rev-parse --short HEAD 2>/dev/null; }

alias flake="git diff --name-only | grep '\.py$' | xargs pyflakes"
alias flake_commit="git diff HEAD^ --name-only | grep '\.py$' | xargs pyflakes"

alias dirty='git ls-files --modified --unmerged | awk '\''{ print $4 }'\'' | sort -u'
alias subdirty='dirty | xargs subl --new-window'
complete -o default -o nospace -F _gitk gitx

alias co='git checkout'
complete -o default -o nospace -F _git_checkout co

alias push.='git push origin HEAD'
alias push+='git push origin +HEAD'
alias push-='git push origin :$(git rev-parse --symbolic-full-name HEAD)'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"

if [ $(which virtualenvwrapper.sh 2>/dev/null) ]; then
    source $(which virtualenvwrapper.sh)
fi
