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
"Plug 'valloric/youcompleteme'
Plug 'airblade/vim-gitgutter'

call plug#end()

""""""""""""""""""""""""""""""""
"""""""" Basic Settings """"""""
"""""""""""""""""""""""""""""""""

set number " Show line numbers
set hls " Highlight search
set ic " Ignore case

""" Tabs
set expandtab " tab to spaces
set tabstop=2 " Tab width
set shiftwidth=2
set softtabstop=2

set cursorline " Highlight current line

"" Invisible chars
set list

colo seoul256

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\" " Different cursor while in insert and command mode
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
