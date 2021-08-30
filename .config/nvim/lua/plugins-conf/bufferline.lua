require'bufferline'.setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
    indicator_icon = '',
    separator_style = { '', '' }
  },
  highlights = {
    background = {
      guibg = '#1E2127',
    },
    buffer_selected = {
      guibg = 'none',
    },
  },
})
