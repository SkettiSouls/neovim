-- Enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Autos
vim.go.autoread = true

-- Set neovim to send all copied text to the plus buffer. (i.e. delete or yank)
vim.go.clipboard = "unnamedplus"

-- Enable automatic folding
vim.opt.foldmethod = "marker"

-- Always vsplit to the right
vim.opt.splitright = true
