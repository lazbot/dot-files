if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export CLICOLOR=1

if [ $(uname) = 'Darwin' ] ; then
    # if I'm on MacOS X...

    if [ "${SSH_CONNECTION}" ] ; then
        # if I'm only on MacOS X because I SSH-ed into it...
        export EDITOR='vim'
        export EDITOR_NEW_WINDOW='vim'
    else
        # ...nope, I'm really on MacOS X.  Not just through SSH.
        export EDITOR='subl -w'
        export EDITOR_NEW_WINDOW='subl --new-window'
        export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Documents/Vagrant/"

        alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
    fi

    alias ll='ls -FTGalh'

    function fx() {
        find . -name $1 | xargs ls -FTGalhd
    }

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    export GOPATH=/Users/wolf/Work/go
    # [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

    # Setting PATH for Python 2.7
    PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
    export PATH

    # Setting PATH for Python 3.5
    PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
    export PATH
else
    alias ls='ls --color=always'
    alias ll='ls --color=always -Falh'
    export EDITOR='vim'
    export EDITOR_NEW_WINDOW='vim'

    if [ -f ~/.git-completion.bash ] ; then
        source ~/.git-completion.bash
    fi
    if [ -f ~/.git-prompt.sh ] ; then
        source ~/.git-prompt.sh
    fi

    function fx() {
        find . -name $1 | xargs ls --color=always -Falhd
    }

    export PATH=$PATH:/usr/local/sbin:~/bin
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

export PS1='\n\! \u@$(uname -n):\[\e[34m\]\W\[\e[0m\]$(virtualenv_info) $(__git_ps1 "\[\e[32m\][%s $(tip)]\[\e[0m\]")\$ '

export HISTSIZE=10000
export HISTIGNORE="&:ls:[bf]g:exit:history:..:make:git pull:git commit"
shopt -s histappend cdspell autocd

function did() { history | grep $1 | grep -v did; }

# Don't bind if I'm in GoSublime's 9o shell
if [ -z "${_fn}" ]; then
    bind '"\t":menu-complete'
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
fi

function f() {
    # usage: f <name>
    # find the filesystem object with the given name
    find . -name $1 2>/dev/null
}

function fcd() {
    # usage: fcd <directory_basename>
    # example: fcd js
    # find the directory with the given name, cd-ing into the first match found
    path=$(find . -name $1 -type d 2>/dev/null | awk "BEGIN { getline; print }")
    cd $(dirname $path)
}

function cdtop() {
    # usage: cdtop
    # change directory to the top-level of a git working-copy
    git_dir=$(git rev-parse --git-dir)
    if [ -n "$git_dir" ]; then
        cd "$git_dir/../"
    fi
}

function since_commit() {
    # usage: since_commit 12345
    # usage: since_commit HEAD~3
    # list all the files modified by all the commits since the given commit,
    #   including currently unstaged changes
    commit=${1:-HEAD}
    git diff $commit --name-only --relative
}

function in_commit() {
    # usage: in_commit 12345
    # usage: in_commit HEAD~3
    # list all the files modified as part of the given commit
    commit=${1:-HEAD}
    git diff $commit ${commit}\^ --name-only --relative
}

function dirty() {
    # git ls-files --modified --unmerged | awk '{ print $4 }' | sort -u
    git ls-files --modified | sort -u
}

if [ $(command -v pyflakes) ]; then
    # only define pyflakes commands if pyflakes is available

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
fi

if [ $(command -v pylint) ]; then
    # only define pylint commands if pylint is available

    function pylint_since() {
        since_commit $1 | grep '\.py$' | xargs pylint
    }

    function pylint_commit() {
        in_commit $1 | grep '\.py$' | xargs pylint
    }

    function pylint_dirty() {
        dirty | grep '\.py$' | xargs pylint
    }
fi

if [ $(command -v jshint) ]; then
    # only define jshint commands if jshint is available

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
fi

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

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"

if [ $(command -v virtualenvwrapper.sh) ]; then
    source $(which virtualenvwrapper.sh)
fi
