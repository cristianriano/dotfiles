execute pathogen#infect()  

filetype on " Detect type of file
syntax on " Auto highlight syntax

let NERDTreeShowHidden=1
let mapleader=',' 

noremap <leader>t :NERDTreeToggle <CR> " Map to specific actions of NERDTree
noremap <leader>f :NERDTreeFind <CR>

set number " Show line numbers
set hls " Highlight search
set ic " Ignore case
set expandtab " tab to spaces
set tabstop=2 " Tab width
set shiftwidth=2
set softtabstop=2
set cursorline " Highlight current line

set autoindent
set smartindent

let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Different cursor while in insert and command mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
