local lazygit_group = vim.api.nvim_create_augroup('lazygit', { clear = true })

-- We use the name used in vim/neovim
local alternate_file = ""
local git_open_method = ""

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

local function close_lazygit_window()-- {{{
  local _, git_win = find_git()

  if git_open_method ~= 'buf' then
    vim.cmd('close' .. tostring(git_win))
  elseif vim.fn.expand('#') == "" then
    vim.cmd.enew()
  else
    vim.cmd.edit(alternate_file)
  end
end-- }}}

local function bind_local()-- {{{
  local git_buf_name, _ = find_git()
  local git_buf = _helpers.lib.get_buf_table()[git_buf_name]

  -- We localize the keybind to close the lazygit window in order to prevent git opening in other toggleterm.
  vim.keymap.set('t', '<leader>g', function() close_lazygit_window() end, { buffer = git_buf })

  -- Quit without the 'process exited 0' prompt, or when lazygit is hung (i.e. ran command without `; exit` at the end)
  vim.keymap.set('t', '<C-q>', function() vim.cmd('bdelete!') end, { buffer = git_buf })
end-- }}}

function open_git_buf()-- {{{
  local git_buf, _ = find_git()
  alternate_file = vim.api.nvim_buf_get_name(0)
  git_open_method = 'buf'

  if git_buf ~= nil then
    vim.cmd.edit(git_buf)
  else
    vim.cmd.edit('term://lazygit')
  end

  bind_local()
end-- }}}

local function open_git_split(open)-- {{{
  local git_buf, _ = find_git()
  alternate_file = vim.api.nvim_buf_get_name(0)
  git_open_method = open

  if git_buf ~= nil then
    vim.cmd(open .. " " .. git_buf)
  else
    vim.cmd(open .. " term://lazygit")
  end

  bind_local()
end-- }}}

bind('n', '<leader>g', function() open_git_buf() end)
bind('n', '<leader>G', function() open_git_split('vsplit') end)

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
