local lazygit = vim.api.nvim_create_augroup('lazygit', { clear = true })

local function spawn_git()
  local buf_table = flake.lib.get_buf_table()
  for k, v in pairs(buf_table) do
    local git_buf = string.match(k, '^term://.*:lazygit')
    if buf_table[git_buf] ~= nil then
      vim.cmd.vsplit(git_buf)
      return
    end
  end
  vim.cmd.vsplit('term://lazygit')
end

-- TODO: make lazygit's `edit` command open in a new buffer, and
-- replace the laygit window with the new buffer
local function git_window()
  local win_table = flake.lib.get_win_table()
  for buf, win in pairs(win_table) do
    local git_buf = string.match(buf, '^term://.*:lazygit')
    if win_table[git_buf] ~= nil then
      vim.cmd('close' .. tostring(win))
      return
    end
  end
  spawn_git()
end

bind('t', '<C-Esc>', '<C-\\><C-n>', { noremap = true })
bind({'n', 't'}, '<leader>g', git_window)

-- Remove line numbers from terminal windows
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*:lazygit",
  group = lazygit,
  command = "setlocal nonumber norelativenumber"
})

-- Always enter terminal mode when opening/switching to lazygit
vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter"}, {
  pattern = "term://*:lazygit",
  group = lazygit,
  command = "startinsert",
})
