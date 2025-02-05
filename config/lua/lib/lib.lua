local function gen_tabs(iter)-- {{{
  local tabs = ""
  for i = 0, iter do
    tabs = tabs .. "  "
  end
  return tabs
end
_helpers.lib.gen_tabs = gen_tabs-- }}}

local function parse_value(item, iter)-- {{{
  local iter = iter or 0
  local value = ""

  if type(item) == "table" then
    value = value .. "{"

    for k, v in pairs(item) do
      local nest = parse_value(v, iter + 1)
      value = value .. "\n" .. gen_tabs(iter) .. tostring(k) .. " = " .. nest
    end

    value = value .. "\n" .. gen_tabs(iter - 1) .. "}"
  else
    value = value .. tostring(item)
  end
  return value
end
_helpers.lib.parse_value = parse_value-- }}}

local function print_table(table)-- {{{
  for k, v in pairs(table) do
    print(tostring(k) .. " = " .. parse_value(v))
  end
end
_helpers.lib.print_table = print_table-- }}}

local function get_buf_table()-- {{{
  local buf_table = {}
  for _, i in pairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(i)
    buf_table[buf_name] = i
  end
  return buf_table
end
_helpers.lib.get_buf_table = get_buf_table-- }}}

local function get_win_table()-- {{{
  local win_table = {}
  -- Nvim api uses window id's, but `close` (and presumably other vimscript cmds) use window *number* (the table keys)
  for win, id in pairs(vim.api.nvim_list_wins()) do
    local win_buf = vim.api.nvim_win_get_buf(id)
    local win_buf_name = vim.api.nvim_buf_get_name(win_buf)
    win_table[win_buf_name] = win
  end
  return win_table
end
_helpers.lib.get_win_table = get_win_table-- }}}
