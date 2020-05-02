filetype on " Detect type of file
syntax on " Auto highlight syntax

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

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\" " Different cursor while in insert and command mode
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
