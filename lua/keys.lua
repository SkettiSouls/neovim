-- Switch windows with Ctrl+arrow keys
vim.keymap.set('n', '<C-left>', '<C-w>h')
vim.keymap.set('n', '<C-down>', '<C-w>j')
vim.keymap.set('n', '<C-up>', '<C-w>k')
vim.keymap.set('n', '<C-right>', '<C-w>l')

-- Resize windows with alt+arrow keys
vim.keymap.set('n', '<A-left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<A-down>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<A-up>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<A-right>', '<Cmd>vertical resize +2<CR>')

-- Source files
vim.keymap.set('n', '<leader><leader>x', '<Cmd>luafile %<CR>')
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Ctrl + Esc to exit terminal mode
vim.keymap.set('t', '<C-Esc>', '<C-\\><C-n>')
