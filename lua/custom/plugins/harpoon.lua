local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} },
    config = function()
        local harpoon = require("harpoon")
        

        harpoon:setup({})
        -- basic telescope configuration
--        local conf = require("telescope.config").values
--        local function toggle_telescope(harpoon_files)
--            local file_paths = {}
--            for _, item in ipairs(harpoon_files.items) do
--                table.insert(file_paths, item.value)
--            end
--
--            require("telescope.pickers").new({}, {
--                prompt_title = "Harpoon",
--                finder = require("telescope.finders").new_table({
--                    results = file_paths,
--                }),
--                previewer = conf.file_previewer({}),
--                sorter = conf.generic_sorter({}),
--            }):find()
--        end
        nmap("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
             "Open harpoon window")
        nmap("<leader>a", function() harpoon:list():append() end)
        nmap("<C-H>", function() harpoon:list():select(1) end)
        nmap( "<C-t>", function() harpoon:list():select(2) end)
        nmap( "<C-n>", function() harpoon:list():select(3) end)
        nmap( "<C-S>", function() harpoon:list():select(4) end)
        -- Toggle previous & next buffers stored within Harpoon list
        nmap( "<C-S-P>", function() harpoon:list():prev() end)
        nmap( "<C-S-N>", function() harpoon:list():next() end)
    end
}

