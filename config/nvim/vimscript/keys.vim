" Switch windows with arrow keys
nnoremap <C-left> <C-w>h
nnoremap <C-down> <C-w>j
nnoremap <C-up> <C-w>k
nnoremap <C-right> <C-w>l

" Switch windows with vim keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows with arrow keys
nnoremap <silent><A-left> :vertical resize -2<CR>
nnoremap <silent><A-down> :resize +2<CR>
nnoremap <silent><A-up> :resize -2<CR>
nnoremap <silent><A-right> :vertical resize +2<CR>

" Resize windows with arrow keys
nnoremap <silent><A-h> :vertical resize -2<CR>
nnoremap <silent><A-j> :resize +2<CR>
nnoremap <silent><A-k> :resize -2<CR>
nnoremap <silent><A-l> :vertical resize +2<CR>

" Shortcuts
nnoremap <C-w> <esc>:w<CR>
inoremap <C-w> <esc>:w<CR>
