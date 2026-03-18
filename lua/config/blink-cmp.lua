local blink = require('blink.cmp')

blink.setup({
  appearance = { nerd_font_variant = 'mono' },
  signature = { enabled = true },

  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      window = {
        border = 'rounded',
        -- TODO: Figure out how to set the highlighting of the separator
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:None,EndOfBuffer:BlinkCmpDoc',
      },
      -- TODO?: Customize how the doc window is drawn
      -- draw = function(data)
      -- end
    },
    menu = {
      border = 'rounded',
      draw = { align_to = 'none', },
      winhighlight = 'Normal:Normal,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None'
    },
  },

  keymap = {
    preset = 'super-tab',
    ['<C-S-K>'] = { function(cmp) cmp.scroll_documentation_up(1) end },
    ['<C-S-J>'] = { function(cmp) cmp.scroll_documentation_down(1) end },
  },
})
