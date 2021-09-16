set tabstop=2 softtabstop=2
set shiftwidth=4
set expandtab
set smartindent
set nowrap

set guicursor=
set relativenumber
set nu
set scrolloff=8
set colorcolumn=80

set incsearch
set hidden
set noerrorbells

set signcolumn=yes

" Prepare VIM-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'gruvbox-community/gruvbox'
call plug#end()