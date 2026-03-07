local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope grep_string search=<CR>')
vim.keymap.set('n', '<leader>fib', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)

telescope.setup({
  defaults = vim.tbl_extend('keep', require('plugins.telescope.ivy-bars'), {}),
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
