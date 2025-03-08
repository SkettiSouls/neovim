-- Default
vim.go.autoindent = true
vim.go.tabstop = 4
vim.go.shiftwidth = 4

-- 2 Spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua", "nix", "haskell", "nu", "sh"},
  command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
