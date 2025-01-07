local function gen_tabs(iter)-- {{{
  local tabs = ""
  for i = 0, iter do
    tabs = tabs .. "  "
  end
  return tabs
end
flake.lib.gen_tabs = gen_tabs
-- }}}

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
flake.lib.parse_value = parse_value
-- }}}

local function print_table(table)-- {{{
  for k, v in pairs(table) do
    print(tostring(k) .. " = " .. parse_value(v))
  end
end
flake.lib.print_table = print_table
-- }}}
