-- Enable hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set default tab spacing to 2.
vim.go.autoindent = true
vim.go.autoread = true
vim.go.smarttab = true
vim.go.shiftwidth = 2
vim.go.softtabstop = -1

-- Set neovim to send all copied text to the plus buffer. (i.e. delete or yank)
vim.go.clipboard = "unnamedplus"

-- Set fold method to marker ( default: {{{  }}} )
vim.go.foldmethod = "marker"
