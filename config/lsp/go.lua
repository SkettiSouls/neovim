vim.lsp.config['gopls'] = {
  cmd = { "gopls" },
  root_markers = { "go.mod", "main.go" },
  filetypes = { "go", "gomod" }
}
