vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true, -- TODO: Figure out how to hide on current line
})

vim.lsp.enable({
  'gopls',
  'nixd',
  'rust-analyzer'
})
