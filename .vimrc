scriptencoding utf-8
set encoding=utf-8

""""""""""""""""""""""""""""""""""
""""""" Vim-Plug Block """""""""""
""""""""""""""""""""""""""""""""""
" Installer
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-sensible'

Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-signify'

Plug 'valloric/youcompleteme', {
  \ 'do': 'cd ~/.vim/plugged/youcompleteme && python3 install.py --all'
  \ }
Plug 'slashmili/alchemist.vim'

Plug 'preservim/nerdtree'
Plug 'wincent/command-t', {
  \ 'do': 'cd ruby/command-t/ext/command-t &&
  \ /usr/local/opt/ruby/bin/ruby extconf.rb && make'
  \ }

call plug#end()

""""""""""""""""""""""""""""""""
"""""""" Basic Settings """"""""
"""""""""""""""""""""""""""""""""

set showcmd
set number " Show line numbers
set hls " Highlight search
set ic " Ignore case
set incsearch " Start searching as typing
set hidden " Hide buffers when opening another file
set hlsearch " Higlight all matches

set textwidth=0
set colorcolumn=80

""" Mouse
silent! set ttymouse=xterm2
set mouse=a

set clipboard=unnamed " Share clipboard with OS

""" Tabs
set expandtab " tab to spaces
set tabstop=2 " Tab width
set shiftwidth=2
set softtabstop=2

set cursorline " Highlight current line

set autoindent
set smartindent

"" Invisible chars
set list

"" Vim tabs
set switchbuf=useopen,usetab
" Autosave
set autowriteall
au TabLeave * :wa

colo seoul256

let &t_SI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\" " Different cursor while in insert and command mode
let &t_EI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

let NERDTreeShowHidden=1

let g:CommandTAcceptSelectionCommand='CommandTOpen tabe'

"" Keybindings
let mapleader='`'

noremap <leader>t :NERDTreeToggle <CR>
noremap <leader>f :NERDTreeFind <CR>
noremap <leader>p :CommandT <CR>

noremap <leader>n :tabnew <CR>
noremap <leader>w :tabclose <CR>
noremap <leader>[ :tabprevious <CR>
noremap <leader>] :tabnext <CR>
