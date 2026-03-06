local direnv = require('direnv')
local augroup = vim.api.nvim_create_augroup('DirenvReload', { clear = true })

direnv.setup({
  bin = "direnv",
  autoload_direnv = true,
  statusline = {
    enabled = true,
    icon = "󱚟"
  },
})

-- Reload when leaving the directory
vim.api.nvim_create_autocmd('User', {
  group = augroup,
  pattern = "DirenvLoaded",
  callback = function()
    vim.api.nvim_create_autocmd('DirChanged', {
      once = true,
      group = augroup,
      callback = function() direnv.check_direnv() end
    })
  end
})
