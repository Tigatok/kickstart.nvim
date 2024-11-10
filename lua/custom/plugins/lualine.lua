local trouble = require('trouble')
return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff'},
      --lualine_c = {{'filename', path=1}},
      lualine_c = {
        {
          'filename',
          path = 1,
        },
        {
        'diagnostics',
        sources = { 'nvim_diagnostic' },  -- Use the built-in LSP diagnostics source
        sections = { 'error', 'warn', 'hint', 'info' },
        diagnostics_color = {
          error = { fg = '#ec5f67' },
          warn  = { fg = '#e0af68' },
          hint  = { fg = '#10B981' },
          info  = { fg = '#0db9d7' },
        },
        colored = true,
        update_in_insert = false,
        always_visible = true,
      },
      },
      lualine_x = {'encoding' },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    tabline = {
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  },
}
