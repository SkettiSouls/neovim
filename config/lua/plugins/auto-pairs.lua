local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

npairs.setup({
  fast_wrap = {},
})

npairs.add_rules {
  -- Add  `<>` pair
  Rule("<", ">")
    -- Avoid pairing on `a <` (less than/greater than)
    :with_pair(cond.not_before_text(" "))
    :with_move(function(opts)
      return opts.char == '>'
    end),

  -- Handle bracket padding
  Rule(' ', ' ')
    :with_pair(function(opts)
      -- Check if we are inserting a space in (), [], or {}
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2]
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1] .. '  ' .. brackets[1][2],
        brackets[2][1] .. '  ' .. brackets[2][2],
        brackets[3][1] .. '  ' .. brackets[3][2]
      }, context)
    end)
}

-- Handle this situation: `{ | }` -> `<cr>`
for _, bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == bracket[2] end)
      :with_del(cond.none())
      :use_key(bracket[2])
      -- Removes the trailing whitespace that can occur without this
      :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
  }
end
