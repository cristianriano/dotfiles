execute pathogen#infect()  

filetype on 
syntax on 

let NERDTreeShowHidden=1
let mapleader=',' 

noremap <leader>t :NERDTreeToggle <CR>
noremap <leader>f :NERDTreeFind <CR>

set number 
set hls " Highlight search
set ic " Ignore case
set tabstop=2
set shiftwidth=2
set softtabstop=2
set cursorline

set autoindent
set smartindent

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
