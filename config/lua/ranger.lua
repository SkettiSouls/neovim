-- TODO: Wrap Ranger to be able to add file types to '${VISUAL:-EDITOR} -- "$@"'

-- Replace Netrw with Ranger
vim.g.rnvimr_enable_ex = 1

-- Hide Ranger after picking a file
vim.g.rnvimr_enable_picker = 1

-- Wipe buffers of files deleted by Ranger
vim.g.rnvimr_enable_bw = 1

-- Window shadow (100 to disable)
vim.g.rnvimr_shadow_winblend = 100

-- Hide files present in gitignore
vim.g.rnvimr_hide_gitignore = 0

-- Keybinds
vim.keymap.set('n', '<leader>f', '<cmd>RnvimrToggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>f', '<esc><cmd>RnvimrToggle<cr>', { noremap = true, silent = true })
vim.keymap.set('i', '<leader>f', '<esc><cmd>RnvimrToggle<cr>', { noremap = true, silent = true })
