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
vim.keymap.set ('n', '<a-left>', '<cmd>vertical resize -2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-down>', '<cmd>resize +2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-up>', '<cmd>resize -2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-right>', '<cmd>vertical resize +2<cr>', { noremap = true, silent = true })

-- Resize windows with alt+vim keys
vim.keymap.set ('n', '<a-h>', '<cmd>vertical resize -2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-j>', '<cmd>resize +2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-k>', '<cmd>resize -2<cr>', { noremap = true, silent = true })
vim.keymap.set ('n', '<a-l>', '<cmd>vertical resize +2<cr>', { noremap = true, silent = true })

-- Save current buffer
vim.keymap.set ('n', '<leader>w', '<Cmd>w<CR>', { noremap = true, silent = true })

-- Remove highlights
vim.keymap.set('n', '<leader>h', '<Cmd>noh<CR>', { noremap = true, silent = true })
