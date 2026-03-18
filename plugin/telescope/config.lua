local builtin = require('telescope.builtin')
local telescope = require('telescope')

-- Use oil current dir when in oil
local function oil_aware_picker(func, opts)
  opts = opts or {}
  if vim.bo.filetype == "oil" then
    ---@diagnostic disable-next-line: different-requires Not sure why lua_ls thinks 'oil' and 'plugins.oil' are the same
    opts = vim.tbl_deep_extend('keep', opts, { cwd = require('oil').get_current_dir() })
  end
  func(opts)
end

vim.keymap.set('n', '<leader>ff', function() oil_aware_picker(builtin.find_files) end)
vim.keymap.set('n', '<leader>fg', function() oil_aware_picker(builtin.live_grep) end)
vim.keymap.set({ 'n', 'v' }, '<leader>fc', function() oil_aware_picker(builtin.grep_string) end)
vim.keymap.set('n', '<leader>fib', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fr', builtin.resume)

-- Open pickers from root directory
vim.keymap.set('n', '<leader>rff', function() builtin.find_files({ cwd = find_root() }) end)
vim.keymap.set('n', '<leader>rfg', function() builtin.live_grep({ cwd = find_root() }) end)
vim.keymap.set({ 'n', 'v' }, '<leader>rfc', function() builtin.grep_string({ cwd = find_root() }) end)

telescope.setup({
  defaults = {
    layout_strategy = "ivybars",
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

telescope.load_extension('fzf')
