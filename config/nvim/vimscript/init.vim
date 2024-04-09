" Sources
source $HOME/.config/nvim/keys.vim
source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/ranger.vim
source $HOME/.config/nvim/rice.vim
source $HOME/.config/nvim/rust/cmp.vim

" suda.vim
let g:suda_smart_edit = 1

" LSP requires
lua require'lspconfig'.rust_analyzer.setup({})
lua require'lspconfig'.clangd.setup{}
