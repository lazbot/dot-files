" .vimrc

set nocompatible    " this Vim, not vi, so act like it
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch

set ignorecase      " searches are case-insensitive
set smartcase       " ...unless you actually include capital letters in the search string

set laststatus=2    " always show the status line
set cmdheight=2     " enlarge the command area to two lines
set number          " display line numbers
set ruler           " show current line number, position in line, percentage in file on the status line

set splitright      " make splitting act more like one would expect: open new splits to the right
set splitbelow      " ...and/or below the current window

set backspace=indent,eol,start
set autoindent
set nostartofline
set confirm
set visualbell
set mouse=a
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

set shiftwidth=4
set softtabstop=4
set expandtab

nnoremap <C-L> :noh<CR><C-L>

autocmd BufEnter *.py set expandtab ts=4 sw=4 softtabstop=4 smarttab smartindent expandtab
    \ cinwords=if,elif,else,for,while,try,except,finally,def,class
    \ list listchars=tab:>- backspace=indent,eol,start tw=79 nocin noai
