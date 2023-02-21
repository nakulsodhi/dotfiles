
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup()
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.keymap.set('n', '<c-n>','<:NvimTreeFindFileToggle<CR>')



