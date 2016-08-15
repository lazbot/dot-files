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

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

Plugin 'pangloss/vim-javascript'
Plugin 'StanAngeloff/php.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'chikamichi/mediawiki.vim'

Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'NLKNguyen/papercolor-theme'
set t_Co=256
set background=light

let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree
Plugin 'scrooloose/nerdtree'

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
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
" }}}

" Python files {{{
augroup filetype_python
    autocmd FileType python set foldmethod=indent
augroup END
" }}}

" Mappings and abbreviations {{{
iabbrev @@ Wolf@zv.cx

let mapleader = ","
let maplocalleader = "\\"

" Edit my ~/.vimrc in a new vertical split, source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Highlight whitespace errors, clear highlighting
nnoremap <leader>w :2match Error /\v\s+$/<cr>
nnoremap <leader>W :2match none<cr>

" Toggle relative line numbers for easy motion
nnoremap <leader>r :set relativenumber!<cr>
" Toggle list view
nnoremap <leader>l :set list!<cr>

" move the current line down
nnoremap - @='ddp'<cr>
" move the current line up
nnoremap _ @='ddkP'<cr>

" <F1> toggles NERDTree's directory window
nnoremap <silent> <F1> :NERDTreeToggle<cr>
" <F11> toggles the YankRing window
nnoremap <silent> <F11> :YRShow<cr>

" Get out of insert mode without stretching for <Esc>
inoremap jk <Esc>
vnoremap jk <Esc>
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

"colorscheme PaperColor
