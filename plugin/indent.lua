local group = vim.api.nvim_create_augroup('IndentStyling', { clear = true })

twospace = {
  'json',
  'lua',
  'nix',
  'sh',
}

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = twospace,
  callback = function()
    vim.cmd('setlocal expandtab shiftwidth=2')
  end
})
