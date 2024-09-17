local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'codedark', -- 'codedark' closely matches vim-airline
    component_separators = { left = '', right = '∣' },
  },

  sections = {
    lualine_y = {
      -- 'progress',
      'location',
    },

    lualine_z = {
      'ctime',
    },
  },

  extensions = {
    'toggleterm',
  },
})
