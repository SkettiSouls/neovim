" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 100

nnoremap <silent> <leader>f :RnvimrToggle<CR>
vnoremap <silent> <leader>f <esc>:RnvimrToggle<CR>
inoremap <silent> <leader>f <esc>:RnvimrToggle<CR>

