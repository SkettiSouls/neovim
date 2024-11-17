local fm = require('tfm')


fm.setup {
  replace_netrw = true,
  enable_cmds = true,

  ui = {
    border = "single",
    height = 0.85,
    width = 0.85,
  },
}

bind({'n', 'v', 'i'}, '<leader>f', "<cmd>Tfm<cr>")
