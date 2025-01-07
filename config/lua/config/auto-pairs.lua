local Rule = require('nvim-autopairs.rule')
local pairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

pairs.setup({
  fast_wrap = {},
})

-- Add `<>` pair
pairs.add_rule(Rule("<", ">"):with_pair(
  -- Avoid pairing on `a <` (less than/greater than)
  cond.not_before_text(" ")):with_move(
    function(opts)
      return opts.char == '>'
    end))
