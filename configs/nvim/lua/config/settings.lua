vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.builtin = 0
vim.g.mapleader = ' '
vim.wo.nu = true
vim.wo.rnu = true
vim.wo.wrap = false
vim.cmd.colorscheme 'adwaita'
vim.cmd 'set nofoldenable'
vim.opt.fillchars = vim.o.fillchars .. 'eob: '
vim.opt.cmdheight = 0
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
