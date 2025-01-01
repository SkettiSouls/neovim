local oil = require('oil')
local actions = require('oil.actions')
local telescope = require('telescope.builtin')
local origin = "" -- Needed for `cd` keybind

bind('n', '-', "<cmd>Oil<cr>")

oil.setup({
  default_file_explorer = true,
  watch_for_changes = true,

  columns = {
    "permissions",
    "size",
    "mtime",
    "icon",
  },

  keymaps = {
    ["q"] = "actions.close",
    ["<C-p>"] = { "actions.preview", opts = { vertical = true, split = "botright" }, },

    -- Jump to $HOME on first use, and then jump back on second.
    ["cd"] = function()
      if origin == "" then
        origin = oil.get_current_dir()
        vim.cmd.cd()
        actions.open_cwd.callback()
      elseif origin ~= oil.get_current_dir() then
        vim.cmd.cd(origin)
        actions.open_cwd.callback()
        origin = ""
      end
    end,

    -- Telescope
    ["ff"] = function()
      telescope.find_files({ cwd = oil.get_current_dir() })
    end,

    ["fg"] = function()
      telescope.grep_string({
        cwd = oil.get_current_dir(),
        search = "",
      })
    end,
  },
})
