call plug#begin('~/.config/nvim/autoload/plugged')

" Surround
Plug 'tpope/vim-surround'
" C
Plug 'j-hui/fidget.nvim'
" Rust stuff
Plug 'neovim/nvim-lspconfig'
" Plug 'simrat39/rust-tools.nvim'
" Plug 'rust-lang/rust.vim'
" CMP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" Airline
Plug 'vim-airline/vim-airline'
" Startify
Plug 'mhinz/vim-startify'
" Commenting keybinds
Plug 'tpope/vim-commentary'
" Highlighted yank
Plug 'machakann/vim-highlightedyank'
" Autopairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Gooder Ranger
Plug 'kevinhwang91/rnvimr'
" Colorizer
Plug 'norcalli/nvim-colorizer.lua'
" vim-terminal
Plug 'tc50cal/vim-terminal'
" suda
Plug 'lambdalisue/suda.vim'
" yuck syntax highlighting
Plug 'elkowar/yuck.vim'
" Search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }




call plug#end()
