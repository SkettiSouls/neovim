local oil = require('oil')
local actions = require('oil.actions')
local telescope = require('telescope.builtin')
local dir_stack = {}

bind('n', '-', "<cmd>Oil<cr>")

local function pushd(dir)-- {{{
  -- Allow using pushd without the prompt by passing `dir as a parameter `(for `cd` bind)
  if dir == nil then
    vim.ui.input({ prompt = 'Enter directory to add to stack: ' }, function(input)
      dir = input
      vim.cmd('echon " "') -- Clear cmd line (prevents errors in the same line)
    end)
  end

  if dir_stack[1] == nil then
    dir_stack[1] = oil.get_current_dir(0)
  end

  -- Show current stack when nothing is passed to the prompt
  if dir == "" or dir == nil then
    vim.print(dir_stack)
    return
  end

  -- Handle relative paths and special characters
  dir = vim.fn.expand(dir) -- Expand special paths (e.g `~` or $HOME)
  if string.match(dir, '^/') == nil then
    dir = oil.get_current_dir(0) .. dir
  end

  if vim.fn.isdirectory(dir) == 1 then
    table.insert(dir_stack, dir)
    vim.cmd.lcd(dir)
    oil.open(dir)
  else
    vim.notify('Error: Directory \'' .. dir .. '\' not found.', vim.log.levels.ERROR)
  end
end-- }}}

local function popd()-- {{{
  local len = vim.tbl_count(dir_stack)
  if len <= 1 then
    vim.notify('Error: Directory stack empty.', vim.log.levels.ERROR)
    return
  end

  vim.cmd.lcd(dir_stack[len - 1])
  actions.open_cwd.callback()
  table.remove(dir_stack, len)

  -- Remove last directory from the stack.
  if vim.tbl_count(dir_stack) == 1 then
    dir_stack[1] = nil
  end
end-- }}}

local function toggle_home()-- {{{
  -- Jump to $HOME on first use, and then jump back on second. (Does nothing if first use is already in $HOME)
  if vim.tbl_count(dir_stack) == 2 then
    popd()
  elseif oil.get_current_dir() ~= vim.env.HOME .. '/' then
    pushd('$HOME')
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
    ["gd"] = { pushd, desc = "Push directory to stack and jump" },
    ["gD"] = { popd, desc = "Pop current directory off stack and jump backwards" },
    ["cd"] = { toggle_home, desc = "Jump back and forth between $HOME and $PWD" },

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
