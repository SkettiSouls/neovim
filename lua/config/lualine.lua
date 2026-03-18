local lualine = require('lualine')

local direnv = function()
  if vim.g.direnvloaded then
    return "󱚟 active"
  else
    return ""
  end
end

local pmclock = function()
  local hour = os.date('%H')
  local suffix = "AM"
  if tonumber(hour) > 12 then
    hour = hour - 12
    suffix = "PM"
  end
  return hour .. os.date(':%M ') .. suffix
end

---@diagnostic disable-next-line: unused-function, unused-local
local clock = function()
  return os.date('%H:%M:%S')
end

lualine.setup({
  options = {
    theme = 'codedark', -- `codedark` closely matches vim-airline
    component_separators = { left = '', right = '∣' },
  },

  sections = {
    lualine_x = {
      direnv,
      'filetype'
    },
    lualine_y = { 'location' },
    lualine_z = { pmclock },
  },

  extensions = { 'toggleterm' },
})
