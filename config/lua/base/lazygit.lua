local lazygit_group = vim.api.nvim_create_augroup('lazygit', { clear = true })

-- TODO: make lazygit's `edit` command open in a new buffer, and
--       replace the lazygit window with the new buffer

local function spawn_git(cmd)-- {{{
  local buf_table = _helpers.lib.get_buf_table()
  for k, v in pairs(buf_table) do
    local git_buf = string.match(k, '^term://.*:lazygit')
    if buf_table[git_buf] ~= nil then
      vim.cmd(cmd .. " " .. git_buf)
      return
    end
  end
  vim.cmd(cmd .. " term://lazygit")
end-- }}}

local function git_window(cmd)-- {{{
  local win_table = _helpers.lib.get_win_table()
  local current_buf = vim.api.nvim_buf_get_name(0)
  local win_num = _helpers.lib.get_table_len(win_table)

  for buf, win in pairs(win_table) do
    local git_buf = string.match(buf, '^term://.*:lazygit')

    if win_table[git_buf] ~= nil then
      -- If current buffer is lazygit and there's no previous file, open a new file
      if current_buf == git_buf and vim.fn.expand('#') == "" then
        vim.cmd.enew()
      -- If current buffer is lazygit, open previous file
      elseif current_buf == git_buf and win_num == 1 then
        vim.cmd.edit('#')
      -- Lazygit must be in a different window, so close that
      else
        vim.cmd('close' .. tostring(win))
      end
      return
    end
  end
  spawn_git(cmd)
end-- }}}

bind('n', '<leader>g', function() git_window('edit') end)
bind('n', '<leader>G', function() git_window('vsplit') end)

-- Remove line numbers from terminal windows
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*:lazygit",
  group = lazygit_group,
  command = "setlocal nonumber norelativenumber"
})

-- Always enter terminal mode when opening/switching to lazygit
vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter"}, {
  pattern = "term://*:lazygit",
  group = lazygit_group,
  command = "startinsert",
})

-- Localize toggle to lazygit buffer (prevents opening git inside toggleterm)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*:lazygit",
  group = lazygit_group,
  callback = function(args)
    bind('t', '<leader>g', function() git_window('edit') end, { buffer = args.buf })
  end
})
