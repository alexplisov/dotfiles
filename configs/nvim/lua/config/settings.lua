vim.builtin = 0

vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.nu = true
vim.wo.rnu = true
vim.wo.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.fillchars = vim.o.fillchars .. 'eob: '
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.cmd.colorscheme 'lunaperche'
vim.cmd 'set nofoldenable'
