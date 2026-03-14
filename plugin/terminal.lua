-- Ctrl+Esc to exit terminal mode
vim.keymap.set('t', '<C-Esc>', '<C-\\><C-n>')

local state = {
  buf = -1,
  win = -1
}

local function spawn(buf)
  buf = buf or nil
  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
  end

  local wincfg = {
    relative = "editor",
    anchor = "SW",
    width = vim.o.columns,
    height = math.ceil(vim.o.lines * 0.4),
    col = 0,
    row = vim.o.lines,
    border = { '', '', '', '', '', '', '', '' }
  }

  local win = vim.api.nvim_open_win(buf, true, wincfg)
  return { buf = buf, win = win }
end

local function toggle()
  if not vim.api.nvim_win_is_valid(state.win) then
    state = spawn(state.buf)
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
      vim.keymap.set('t', '\\t', function() -- \t to prevent spaces being funky
        vim.api.nvim_feedkeys('', 'x', true)
        toggle()
      end, { buffer = true })
    end
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.win)
  end
end

vim.api.nvim_create_user_command("ToggleTerm", toggle, {})
vim.keymap.set('n', '<leader>t', toggle)
