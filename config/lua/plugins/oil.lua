local oil = require('oil')
local actions = require('oil.actions')
local telescope = require('telescope.builtin')
local origin = "" -- Needed for `cd` keybind
local dir_stack = {}

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

    -- pushd
    ["gd"] = function()
      if dir_stack[1] == nil then
        dir_stack[1] = oil.get_current_dir(0)
      end

      vim.ui.input({ prompt = 'Enter directory to add to stack: ' }, function(input)
        -- Show current stack when nothing is passed to the prompt
        if input == "" or input == nil then
          vim.print(dir_stack)
          return
        end

        -- Handle relative paths and special characters
        input = vim.fn.expand(input) -- Expand special paths (e.g `~` or $HOME)
        if string.match(input, '^/') == nil then
          input = oil.get_current_dir(0) .. input
        end

        local path_exists, error = pcall(vim.cmd.tcd, input)
        if path_exists then
          table.insert(dir_stack, input)
          oil.open(input)
        else
          vim.api.nvim_err_writeln('\n' .. error)
        end
      end)
    end,

    -- popd
    ["gD"] = function()
      local len = vim.tbl_count(dir_stack)
      if len <= 1 then
        vim.api.nvim_err_writeln('Error: Directory stack empty')
        return
      end

      vim.cmd.tcd(dir_stack[len - 1])
      actions.open_cwd.callback()
      table.remove(dir_stack, len)

      -- Remove last directory from the stack.
      if vim.tbl_count(dir_stack) == 1 then
        dir_stack[1] = nil
      end
    end,

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
