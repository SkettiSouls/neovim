-- Configures LuaLS for NeoVim
require('lazydev').setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  }
})


vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true, -- TODO: Figure out how to hide on current line
})

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'nixd',
  'rust_analyzer'
})

-- Format on write
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end
      })
    end
  end
})
