-- Switch windows with Ctrl+arrow keys
vim.keymap.set('n', '<C-left>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-down>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-up>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-right>', '<C-w>l', { noremap = true })

-- Switch windows with Ctrl+vim keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- Resize windows with alt+arrow keys
vim.keymap.set('n', '<A-left>', '<Cmd>vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-down>', '<Cmd>resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-up>', '<Cmd>resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-right>', '<Cmd>vertical resize +2<CR>', { noremap = true, silent = true })

-- Resize windows with alt+vim keys
vim.keymap.set('n', '<A-h>', '<Cmd>vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', '<Cmd>resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<Cmd>resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', '<Cmd>vertical resize +2<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader><leader>x', '<Cmd>luafile %<CR>', { silent = true })
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Remove highlights
vim.keymap.set('n', '<leader>h', '<Cmd>noh<CR>', { noremap = true, silent = true })

-- Ctrl + Esc to exit terminal mode
vim.keymap.set('t', '<C-Esc>', '<C-\\><C-n>', { noremap = true })
