--return {
--  'tigatok/nvim-todonotes',
--  config = function()
--    local todonotes = require 'todonotes'
--    vim.keymap.set('n', '<leader>tt', function()
--      todonotes.toggle_notes()
--    end, { desc = 'Toggle TODO Notes' })
--  end,
--}
return {
  dir = '/Users/tmarshall/clients/opensource/nvim-todonotes',
  name = 'todonotes',
  config = function()
    local todonotes = require 'todonotes'
    vim.keymap.set('n', '<leader>tt', function()
      todonotes.toggle_notes()
    end, { desc = 'Toggle Todo Notes (project)' })
    vim.keymap.set('n', '<leader>tT', function()
      todonotes.toggle_notes 'global'
    end, { desc = 'Toggle Todo Notes (global)' })
  end,
}
