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
Plug 'ghifarit53/tokyonight-vim', { 'branch': 'master' }
Plug 'tpope/vim-sensible'

Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-signify'
Plug 'slashmili/alchemist.vim'

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'mechatroner/rainbow_csv'

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

set termguicolors
let g:tokyonight_style = 'storm'
colo tokyonight

"" Cursor shape: block in normal mode, thin line in insert mode
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

let NERDTreeShowHidden=1

"" Keybindings (Space leader like LazyVim)
let mapleader=' '

noremap <leader>e :NERDTreeToggle <CR>
noremap <leader>f :NERDTreeFind <CR>

noremap <leader><space> :FZF <CR>
noremap <leader>o :FZF <CR>

noremap <leader>n :tabnew <CR>
noremap <leader>w :tabclose <CR>
noremap <leader>[ :tabprevious <CR>
noremap <leader>] :tabnext <CR>
