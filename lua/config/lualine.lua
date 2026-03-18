local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'codedark', -- `codedark` closely matches vim-airline
    component_separators = { left = '', right = '∣' },
  },

  sections = {
    lualine_x = {
      -- TODO: Direnv Indicator 󱚟
      'filetype'
    },
    lualine_y = { 'location' },
    lualine_z = { 'ctime' }, -- TODO: Replace with my own implementation
  },

  extensions = { 'toggleterm' },
})
