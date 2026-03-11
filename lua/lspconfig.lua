vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true, -- TODO: Figure out how to hide on current line
})

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'nixd',
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

local direnv = {
  filetypes = {},
  lsps = {
    'rust_analyzer',
  },
}

direnv.filetypes = vim.iter(direnv.lsps):map(function(item) return vim.lsp.config[item].filetypes end):flatten():totable()

-- Delay lsp attach until *after* direnv loads
vim.api.nvim_create_autocmd('FileType', {
  pattern = direnv.filetypes,
  callback = function(args)
    local filter = vim.tbl_filter(
      function(item)
        return vim.tbl_contains(vim.lsp.config[item].filetypes, args.match)
      end,
      direnv.lsps)

    vim.api.nvim_create_autocmd('User', {
      once = true,
      pattern = "DirenvLoaded",
      callback = function() vim.lsp.enable(filter[1]) end
    })
  end
})
