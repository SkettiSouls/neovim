local strats = require('telescope.pickers.layout_strategies')
strats.ivybars = function(picker, max_columns, max_lines, layout_cfg)
  -- Extra line prevents lua_ls formatter being silly
  local layout = strats.bottom_pane(picker, max_columns, max_lines, layout_cfg)


  layout.prompt.border        = { 1, 0, 1, 0 }           -- Disable side borders
  layout.prompt.width         = vim.o.columns            -- Makes borders span the entire ui

  layout.results.col          = 1                        -- Start from left edge
  layout.results.title[1].pos = "N"                      -- Move title to top border
  layout.results.border       = { 1, 0, 0, 0 }           -- Only enable the top border
  layout.results.line         = layout.prompt.line + 2   -- Start from bottom of prompt
  layout.results.width        = layout.results.width + 2 -- Fill in the space to edge/border

  if layout.preview then
    layout.preview.title[1].pos = "N"                      -- Move title to top border
    layout.preview.border       = { 1, 0, 0, 1 }           -- Disable bottom and right border
    layout.preview.line         = layout.prompt.line + 2   -- Start from the bottom of prompt
    layout.preview.width        = layout.preview.width + 1 -- Fill to right edge
    layout.preview.height       = layout.results.height    -- Match height of results
    layout.preview.borderchars  = { '─', '', '', '│', '┬', '', '', '' }
  end

  return layout
end
