vim.lsp.config['rust-analyzer'] = {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.toml", "Cargo.lock" },
  filetypes = { "rust" }
}
