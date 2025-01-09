-- Enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Automatically read buffers on change
vim.go.autoread = true

-- Set neovim to send all copied text to the plus buffer. (i.e. delete or yank)
vim.go.clipboard = "unnamedplus"

-- Enable automatic folding
vim.opt.foldmethod = "marker"

-- Always vsplit to the right
vim.opt.splitright = true

-- Prompt for sudo password in read-only files
vim.g.suda_smart_edit = 1
