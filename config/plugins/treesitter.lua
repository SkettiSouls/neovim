local parsers = require('nvim-treesitter.parsers')

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(parsers),
  callback = function() vim.treesitter.start() end,
})
