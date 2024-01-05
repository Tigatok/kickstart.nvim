-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.wo.relativenumber = true
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv");
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv");
vim.keymap.set('n', "<C-u>", "<C-u>zz");
vim.keymap.set('n', "<C-d>", "<C-d>zz");
vim.keymap.set('n', "n", "nzzzv");
vim.keymap.set('n', "N", "Nzzzv");
vim.keymap.set('n', "<leader>y", "\"+y");
vim.keymap.set('v', "<leader>y", "\"+y");
vim.keymap.set('n', "<leader>Y", "\"+y");
vim.keymap.set("n", "<C-l>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>l", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>x", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n','<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({find_command = {'rg','--files','--hidden','--glob=!**/.git/*','--glob=!**/.idea/*','--glob=!**/.vscode/*','--glob=!**/build/*','--glob=!**/dist/*','--glob=!**/yarn.lock','--glob=!**/package-lock.json'}, })<cr>");
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex);
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.o.scrolloff = 999

return{
  {
    "github/copilot.vim",
    config = function ()
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', {silent = true, expr= true});
      vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', {silent = true, expr= true});
      vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', {silent = true, expr= true});
    end
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme moonfly]])
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function ()

      vim.keymap.set('n', '<leader>tt',function()
        require('trouble').toggle()
      end, {desc="Trouble Toggle"})

      vim.keymap.set('n', '<leader>tn',function()
        require('trouble').next({jump = true, skip_groups = true})
        end, {desc="Trouble Next"})

      vim.keymap.set('n', '<leader>tp',function ()
        require('trouble').previous({jump = true, skip_groups = true})end,
        {desc="Trouble Previous"})
    end
  }

}
