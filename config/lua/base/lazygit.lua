local lazygit_group = vim.api.nvim_create_augroup('lazygit', { clear = true })

-- TODO: make lazygit's `edit` command open in a new buffer, and
--       replace the lazygit window with the new buffer

-- Returns git_buf_name (nil or str), git_win_num (nil or int)
function find_git()-- {{{
  local buf_table = _helpers.lib.get_buf_table()
  local win_table = _helpers.lib.get_win_table()

  for k, _ in  pairs(buf_table) do
    local git_buf = string.match(k, '^term://.*lazygit')

    if buf_table[git_buf] ~= nil and win_table[git_buf] ~= nil then
      return git_buf, win_table[git_buf]
    elseif buf_table[git_buf] ~= nil then
      return git_buf, nil
    end
  end

  return nil, nil
end-- }}}

-- Allows for one bind to close both window types
local function bind_close(cmd)-- {{{
  local git_buf_name, _ = find_git()
  local git_buf = _helpers.lib.get_buf_table()[git_buf_name]

  -- We localize the keybind to the git buffer to prevent git opening in toggleterm.
  vim.keymap.set('t', '<leader>g', function() cmd() end, { buffer = git_buf })
end-- }}}

local function toggle_git_buf()-- {{{
  local git_buf, git_win = find_git()

  if git_win ~= nil then
    if vim.fn.expand('#') == "" then
      vim.cmd.enew()
    else
      vim.cmd.edit('#')
    end
  elseif git_buf ~= nil then
    vim.cmd.edit(git_buf)
  else
    vim.cmd.edit('term://lazygit')
  end

  bind_close(toggle_git_buf)
end-- }}}

local function toggle_git_split(open)-- {{{
  local git_buf, git_win = find_git()

  if git_win ~= nil then
    vim.cmd('close' .. tostring(git_win))
  elseif git_buf ~= nil then
    vim.cmd(open .. " " .. git_buf)
  else
    vim.cmd(open .. " term://lazygit")
  end

  bind_close(toggle_git_split)
end-- }}}

bind('n', '<leader>g', function() toggle_git_buf() end)
bind('n', '<leader>G', function() toggle_git_split('vsplit') end)

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
