local img = require('image')

img.setup ({
  backend = "kitty",
  processor  = "magick_cli",

  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = true,
      filetypes  = { "markdown", },
    },
  },
})
