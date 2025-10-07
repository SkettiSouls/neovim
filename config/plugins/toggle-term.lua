local toggleterm = require('toggleterm')

toggleterm.setup {
  open_mapping = '<leader>t',
  direction = 'vertical',
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  hide_numbers = true,
  autochdir = true,
  start_in_insert = true,
  insert_mappings = true,
  close_on_exit = true,
  auto_scroll = true,
}
