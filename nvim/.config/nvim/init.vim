" Behavior sets
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap

" Visual sets
set guicursor=        " Thick cursor
set relativenumber    " Display relative numbers
set nu                " Current line number
set scrolloff=8       " Offset while browsing through file
set colorcolumn=80    " Vertical column at 80th character
set signcolumn=yes    " Display additional column next to number
set cmdheight=2       " Give more space for displaying messages
syntax on             " Enable syntax highlighting

" Other sets
set incsearch         " start searching while typing
set hidden
set noerrorbells


" Prepare VIM-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Share register with Copy&Paste
set clipboard=unnamed
set clipboard=unnamedplus

" Install plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'gruvbox-community/gruvbox' " color scheme

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'sbdchd/neoformat' " Prettier

Plug 'tpope/vim-fugitive' " Git 
Plug 'lewis6991/gitsigns.nvim' " Git signs

call plug#end()

" Color theme customizations
colo gruvbox
highlight Normal guibg=none

" GitSigns configuration
lua require('gitsigns').setup() 

" Neoformat configuration
let g:neoformat_try_node_exe = 1
let g:neoformat_enabled_javascript = ['prettier']

" Neoformat format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Auto commands
if has("autocmd")
    autocmd bufwritepost init.vim source $MYVIMRC
endif

" Remaps
let mapleader = " "

nnoremap <leader>f <cmd>Neoformat<cr>
nnoremap <leader>so% :so %<cr>
nnoremap <leader>so :so ~/.config/nvim/init.vim<cr>
nnoremap <leader>v :tabedit $MYVIMRC<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fg <cmd>Telescope git_status<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Git maps
nnoremap <leader>g <cmd>Git<cr>
nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gw <cmd>Gwrite<cr>
nnoremap <leader>gh <cmd>Git push<cr>
nnoremap <leader>gl <cmd>Git pull<cr>
