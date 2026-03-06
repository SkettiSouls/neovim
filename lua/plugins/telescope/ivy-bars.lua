local strats = require('telescope.pickers.layout_strategies')
strats.ivy_bars = function(picker, max_columns, max_lines, layout_cfg)
  local layout = strats.bottom_pane(picker, max_columns, max_lines, layout_cfg)

  layout.prompt.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
  layout.results.borderchars = { '─', '│', '─', '│', '├', '┬', '┴', '└' }
  layout.preview.borderchars = { '─', '│', '─', '│', '┬', '┤', '┘', '┴' }

  layout.results.title[1].pos = "N"
  layout.results.border = true

  layout.prompt.line = layout.prompt.line - 1

  layout.preview.title[1].pos = "N"
  layout.preview.col = layout.preview.col - 1
  layout.preview.line = layout.preview.line - 1
  layout.preview.width = layout.preview.width + 1
  layout.preview.height = layout.preview.height + 1

  return layout
end

return {
  layout_strategy = "ivy_bars",
  layout_config = {
    anchor = "S",
    prompt_position = "top",
  }
}
