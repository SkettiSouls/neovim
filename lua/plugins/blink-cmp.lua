local blink = require('blink.cmp')

blink.setup({
  completion = {
    documentation = { auto_show = true },
    ghost_text = { enabled = true }
  },

  sources = {
    per_filetype = {
      lua = { inherit_defaults = true, 'lazydev' }
    },

    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      }
    }
  },

  keymap = {
    preset = 'super-tab',
    ['<C-K>'] = { 'select_prev', 'fallback' },
    ['<C-J>'] = { 'select_next', 'fallback' },
    ['<C-S-K>'] = { function(cmp) cmp.scroll_documentation_up(1) end },
    ['<C-S-J>'] = { function(cmp) cmp.scroll_documentation_down(1) end },
  },
})
