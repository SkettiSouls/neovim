local luagit = require('luagit')

bind('n', '<leader>G', function() luagit.open('vsplit') end)

luagit.setup({
  insert_on_focus = true,
  open_mapping = '<leader>g',
  open_method = 'replace',
  prevent_nesting = true,
})
