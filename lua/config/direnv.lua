local direnv = require('direnv-nvim')

-- Track status
vim.g.direnvloaded = false
vim.api.nvim_create_autocmd("User", {
  group = "direnv-nvim",
  pattern = { 'DirenvReady', 'DirenvNotFound' },
  callback = function(event)
    if event.match == 'DirenvNotFound' then
      vim.g.direnvloaded = false
    else
      vim.g.direnvloaded = true
    end
  end
})

local lstbl = {
  'rust_analyzer',
  'gopls',
}

-- Convert list of language server into table of `ls = { ft, ft, ... }`
for idx, ls in ipairs(lstbl) do
  lstbl[idx] = nil
  lstbl[ls] = vim.lsp.config[ls].filetypes
end

direnv.setup({
  hook = { msg = "" }, -- Setting to `nil` does nothing
  on_direnv_finished = function(data)
    -- Skip loop if envrc not found
    if vim.g.direnvloaded then
      ---@diagnostic disable: param-type-mismatch lsp throws erroneous error
      for k, v in pairs(lstbl) do
        if vim.tbl_contains(v, data.filetype) then
          vim.lsp.enable(k)
        end
      end
    end
  end
})
