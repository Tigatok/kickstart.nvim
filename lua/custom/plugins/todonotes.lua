return {
  dir = "~/clients/dovetail/nvim-todonotes",
  name = "todonotes",
  config = function()
    local todonotes = require("todonotes")
    vim.keymap.set('n', '<leader>tt', function()
      todonotes.toggle_notes()
    end, {desc="Toggle TODO Notes"})
  end
}

