local luagit = require('luagit')

-- TODO: Figure out how to either: allow strings for `luagit.OpenMethod`, or pass `'vsplit'` as `luagit.OpenMethod`
---@diagnostic disable-next-line: param-type-mismatch
vim.keymap.set('n', '<leader>G', function() luagit.open('vsplit') end)

luagit.setup({
  insert_on_focus = true,
  open_mapping = '<leader>g',
  open_method = 'replace',
  prevent_nesting = true,
})
