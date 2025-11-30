-- Default (overridden by filetype plugins)
vim.go.autoindent = true
vim.go.tabstop = 4
vim.go.shiftwidth = 4
vim.go.expandtab = false

local two_spaced = {
  "lua",
  "nix",
  "haskell",
  "sh"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = two_spaced,
  command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  command = "setlocal shiftwidth=4 tabstop=4"
})
