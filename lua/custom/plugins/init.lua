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
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.o.scrolloff = 999
return{}
 
