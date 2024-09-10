vim.g.mapleader = ' '

vim.opt.breakat = " ^I!@*-+;:,./?" -- characters that may cause a line break
vim.opt.breakindent = true -- wrapped line repeats indent true
vim.opt.clipboard = "unnamedplus" -- use the system clipboard 
vim.opt.confirm = true -- ask what to do about unsaved/read-only files
vim.opt.cursorcolumn = true -- highlight the screen column of the cursor
vim.opt.cursorline = true -- highlight the screen line of the cursor
vim.opt.expandtab = false -- use spaces when <Tab> is inserted
-- vim.opt.laststatus = 0
vim.opt.linebreak = true -- wrap long lines at a char from breakat rather than mid word
vim.opt.number = true -- print the line number in front of each line
vim.opt.relativenumber = true -- show relative line number in front of each line
vim.opt.shiftwidth = 4 -- number of spaces to use for (auto)indent step
vim.opt.showmode = false -- message on status line to show current mode
vim.opt.softtabstop = 8 -- number of spaces that <Tab> uses while editing
vim.opt.tabstop = 4 -- number of spaces that <Tab> in file uses
