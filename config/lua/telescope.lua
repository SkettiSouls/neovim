local builtin = require('telescope.builtin')
local telescope = require('telescope')

bind('n', 'ff', builtin.find_files, {})
bind('n', 'fg', builtin.live_grep, {})
bind('n', 'fb', builtin.buffers, {})
bind('n', 'fn', builtin.help_tags, {})

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

telescope.load_extension('fzf')
