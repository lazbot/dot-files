set nocompatible
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch

set ignorecase
set smartcase

set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

set shiftwidth=4
set softtabstop=4
set expandtab

nnoremap <C-L> :noh<CR><C-L>

autocmd BufEnter *.py set expandtab ts=4 sw=4 softtabstop=4 smarttab smartindent expandtab
    \ cinwords=if,elif,else,for,while,try,except,finally,def,class
    \ list listchars=tab:>- backspace=indent,eol,start tw=79 nocin noai
