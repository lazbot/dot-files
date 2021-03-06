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
Plugin 'tweekmonster/braceless.vim'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'tmux-plugins/vim-tmux'

Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'easymotion/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bronson/vim-visual-star-search'
Plugin 'mbbill/undotree'

"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

set background=light
Plugin 'vim-scripts/CycleColor'
Plugin 'NLKNguyen/papercolor-theme'

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
Plugin 'tpope/vim-markdown'

"let g:yankring_min_element_length = 2
"let g:yankring_manage_numbered_reg = 1
"let g:yankring_history_dir = '~/.vim,~/vimfiles,$HOME'
"Plugin 'vim-scripts/YankRing.vim'

let NERDTreeSortOrder=[]
let NERDTreeIgnore=['\.o$[[file]]', '\.pyc$[[file]]']
Plugin 'scrooloose/nerdtree'

let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlPMixed'
Plugin 'ctrlpvim/ctrlp.vim'

"if executable('ag')
"    let g:ackprg = 'ag --vimgrep'
"endif
"Plugin 'mileszs/ack.vim'

"Plugin 'scrooloose/syntastic'
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

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

"set statusline+=%#warningmsg#               " Syntastic
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

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
set clipboard=unnamed,autoselect
set guioptions+=a
set cursorline

set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

" All files {{{
augroup open_and_close
    autocmd!
    " Show the cursorline in the active window when _not_ in insert mode
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline

    " When opening a buffer, restore the exact cursor position if it still
    " exists
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
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
    autocmd FileType python BracelessEnable +indent +highlight-cc2 +fold
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
if has('gui')
    nnoremap <leader>eg :vsplit $MYGVIMRC<cr>
    nnoremap <leader>sg :source $MYGVIMRC<cr>
endif

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
"nnoremap <silent> <F11> :YRShow<cr>

" <F5> toggles the Undotree window
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F1> :NERDTreeToggle<cr>

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
" }}}

" terminal and colorscheme properties {{{
if &term =~ '^screen' || !has('mac')
    colorscheme peachpuff
else
    colorscheme PaperColor
endif

if &term !~ 'builtin_gui'
    set ttymouse=xterm2
endif
" }}}

if has('persistent_undo')
    set undodir=~/.vim/undo/
    set undofile
endif
