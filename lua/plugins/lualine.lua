local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'codedark', -- 'codedark' closely matches vim-airline
    component_separators = { left = '', right = '∣' },
  },

  sections = {
    lualine_x = {
      function()
        return require('direnv').statusline()
      end,
      -- 'fileformat',
      'filetype'
    },
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
