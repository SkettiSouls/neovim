local luagit = require('luagit')
local tl = vim.g.termleader

local tray = {
  relative = "editor",
  anchor = "SW",
  width = vim.o.columns,
  height = math.ceil(vim.o.lines * 0.4),
  col = 0,
  row = vim.o.lines,
}

vim.keymap.set('n', '<leader>lG', function() luagit.toggle(tray) end)

luagit.setup({
  insert_on_focus = true,
  prevent_nesting = true,
  open_mapping = '<leader>lg',

  share_mapping = '\\g',
  keymaps = {
    -- Three maps so that it doesn't matter how long I hold Ctrl
    [tl .. 'lg'] = luagit.toggle,
    [tl .. '<C-l>g'] = luagit.toggle,
    [tl .. '<C-l><C-g>'] = luagit.toggle,
  }
})
