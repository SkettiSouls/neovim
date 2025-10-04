local oil = require('oil')
local actions = require('oil.actions')
local nav = require('oil.navigate')
local telescope = require('telescope.builtin')

bind('n', '-', "<cmd>Oil<cr>")

local function bounce()-- {{{
  -- Jump to/from `$HOME`.
  if nav.stack[1] ~= vim.env.HOME then
    nav.pushd(vim.env.HOME)
  else
    nav.popd()
  end
end-- }}}

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
    ["gd"] = { nav.pushd, desc = "Push directory to stack and jump" },
    ["gD"] = { nav.popd, desc = "Pop current directory off stack and jump backwards" },
    ["cd"] = { bounce, desc = "Jump back and forth between $HOME and $PWD" },

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
