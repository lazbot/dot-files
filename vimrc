" .vimrc

set nocompatible    " this Vim, not vi, so act like it

" Plugins {{{
filetype off        " required by Vundle

" set the runtime path to include Vundle and intitialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
"Plugin 'mileszs/ack.vim'
Plugin 'wincent/command-t'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/scratch.vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'vim-scripts/YankRing.vim'
"Plugin 'Valloric/YouCompleteMe'

let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
let g:yankring_min_element_length = 2
let g:yankring_manage_numbered_reg = 1
let g:yankring_history_dir = '~/.vim,~/vimfiles,$HOME'

call vundle#end()   " required
" }}}

" Settings {{{
set hidden
set showcmd
set hlsearch
set showmatch

set ignorecase      " searches are case-insensitive
set smartcase       " ...unless you actually include capital letters in the search string

set scrolloff=3
set cmdheight=2     " enlarge the command area to two lines
set number          " display line numbers
" statusline {{{
set statusline=%<                           " where to break
set statusline+=%t%M%R                      " leafname, modified, read-only
set statusline+=\ %{fugitive#statusline()}  " if in git repo, git info
set statusline+=%=                          " switch to the right side
set statusline+=%y                          " file type, e.g., [markdown]
set statusline+=\ %-14.(%l,%c%)             " like ruler, line, column
set statusline+=\ %P                        " percentage of file shown
" }}}

set splitright      " make splitting act more like one would expect: open new splits to the right
set splitbelow      " ...and/or below the current window

set nostartofline
set confirm
set visualbell
set mouse=a
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

" Vim files {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0
augroup END

augroup filetype_help
    autocmd!
    autocmd FileType help setlocal scrolloff=0 nonumber
augroup END
" }}}

" Python files {{{
augroup filetype_python
    set foldmethod=indent
augroup END
" }}}

" Mappings and abbreviations {{{
iabbrev @@ Wolf@zv.cx

let mapleader = ","
let maplocalleader = "\\"

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>w :2match Error /\v\s+$/<cr>
nnoremap <leader>W :2match none<cr>

" move the current line down
nnoremap - ddp
" move the current line up
nnoremap _ ddkP

" in insert mode, uppercase the word under the cursor
inoremap <c-U> <esc>lm`viwU``i
" in normal mode, uppercase the word under the cursor
nnoremap <c-U> m`viwU``

" <F11> shows the YankRing window
nnoremap <silent> <F11> :YRShow<cr>
" <F12> opens the scratch buffer (TODO: make this a toggle)
nnoremap <silent> <F12> :Sscratch<cr>

" Get out of insert mode without stretching for <Esc>
inoremap jk <Esc>
inoremap <Esc> <nop>

" Train myself to _not_ use the arrow keys in insert or normal modes
inoremap <Left> <nop>
nnoremap <Left> <nop>
inoremap <Right> <nop>
nnoremap <Right> <nop>
inoremap <Up> <nop>
nnoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Down> <nop>
" }}}
