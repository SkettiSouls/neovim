bind=vim.keymap.set

-- Switch windows with Ctrl+arrow keys
bind('n', '<C-left>', '<C-w>h', { noremap = true })
bind('n', '<C-down>', '<C-w>j', { noremap = true })
bind('n', '<C-up>', '<C-w>k', { noremap = true })
bind('n', '<C-right>', '<C-w>l', { noremap = true })

-- Switch windows with Ctrl+vim keys
bind('n', '<C-h>', '<C-w>h', { noremap = true })
bind('n', '<C-j>', '<C-w>j', { noremap = true })
bind('n', '<C-k>', '<C-w>k', { noremap = true })
bind('n', '<C-l>', '<C-w>l', { noremap = true })

-- Resize windows with alt+arrow keys
bind('n', '<A-left>', '<Cmd>vertical resize -2<CR>', { noremap = true, silent = true })
bind('n', '<A-down>', '<Cmd>resize +2<CR>', { noremap = true, silent = true })
bind('n', '<A-up>', '<Cmd>resize -2<CR>', { noremap = true, silent = true })
bind('n', '<A-right>', '<Cmd>vertical resize +2<CR>', { noremap = true, silent = true })

-- Resize windows with alt+vim keys
bind('n', '<A-h>', '<Cmd>vertical resize -2<CR>', { noremap = true, silent = true })
bind('n', '<A-j>', '<Cmd>resize +2<CR>', { noremap = true, silent = true })
bind('n', '<A-k>', '<Cmd>resize -2<CR>', { noremap = true, silent = true })
bind('n', '<A-l>', '<Cmd>vertical resize +2<CR>', { noremap = true, silent = true })

-- Save current buffer
bind('n', '<leader>w', '<Cmd>w<CR>', { noremap = true, silent = true })

-- Remove highlights
bind('n', '<leader>h', '<Cmd>noh<CR>', { noremap = true, silent = true })
