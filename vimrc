" .vimrc

set nocompatible    " this is Vim, not vi, so act like it

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

"Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
"Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

Plugin 'pangloss/vim-javascript'
Plugin 'StanAngeloff/php.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'tmux-plugins/vim-tmux'

Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'easymotion/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bronson/vim-visual-star-search'

set background=light
Plugin 'vim-scripts/CycleColor'
Plugin 'NLKNguyen/papercolor-theme'

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
Plugin 'tpope/vim-markdown'

let g:yankring_min_element_length = 2
let g:yankring_manage_numbered_reg = 1
let g:yankring_history_dir = '~/.vim,~/vimfiles,$HOME'
Plugin 'vim-scripts/YankRing.vim'

let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlPMixed'
Plugin 'ctrlpvim/ctrlp.vim'

"if executable('ag')
"    let g:ackprg = 'ag --vimgrep'
"endif
"Plugin 'mileszs/ack.vim'

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
set statusline+=%f%M%R                      " leafname, modified, read-only
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
"set pastetoggle=<F11>
set sessionoptions+=resize,unix,slash

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

" Markdown files {{{
augroup filetype_markdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
" }}}

" Python files {{{
augroup filetype_python
    autocmd!
    autocmd FileType python set foldmethod=indent
augroup END
" }}}

" Mappings and abbreviations {{{
iabbrev ehome Wolf@zv.cx
iabbrev ework Wolf@learninga-z.com

let mapleader = "\<space>"
let maplocalleader = "\\"

" Edit my ~/.vimrc in a new vertical split, source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Highlight whitespace errors, clear highlighting
nnoremap <leader>w :2match Error /\v\s+$/<cr>
nnoremap <leader>W :2match none<cr>

" Open the CtrlP's buffer explorer window
nnoremap <leader>b :CtrlPBuffer<cr>

" Toggle relative line numbers for easier motion math
nnoremap <leader>r :set relativenumber!<cr>
" Toggle list view
nnoremap <leader>l :set list!<cr>
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$

" move the current line down (takes a count of distance to move)
"nnoremap - @='ddp'<cr>
" move the current line up (takes a count of distance to move)
"nnoremap _ @='ddkP'<cr>

" <F11> toggles the YankRing window
nnoremap <silent> <F11> :YRShow<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Act naturally when lines wrap
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap 0 g0
nnoremap $ g$
nnoremap gj j
nnoremap gk k
nnoremap g^ ^
nnoremap g$ $
nnoremap g0 0

" Get out of insert mode without stretching for <Esc>
inoremap jk <Esc>
" Don't remap <Esc> as that breaks mouse input

" Train myself _not_ to use the arrow keys in insert or normal modes
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
" }}}

if has('mac')
    colorscheme PaperColor
else
    colorscheme peachpuff
endif

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
