local renderer = require('render-markdown')

renderer.setup({
  enabled = true, -- Automatic rendering on file open
  file_types = { 'markdown', },
})
