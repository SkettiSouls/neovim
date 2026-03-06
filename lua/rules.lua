-- Enable hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Automatically read buffers on change
vim.opt.autoread = true

-- Set neovim to send all copied text to the plus buffer. (i.e. delete or yank)
vim.opt.clipboard = "unnamedplus"

-- Enable automatic folding
vim.opt.foldmethod = "marker"

-- Always vsplit to the right
vim.opt.splitright = true

-- Set default tab size to 4
vim.opt.shiftwidth = 4

-- Prompt for sudo password in read-only files
vim.g.suda_smart_edit = 1
