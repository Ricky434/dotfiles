vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.o.breakindent = true

vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.o.timeoutlen = 300

vim.opt.colorcolumn = "80"
-- Default is menu,preview, have to try it out
vim.o.completeopt = 'menuone,noselect'

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "auto:4"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.o.fillchars = [[fold: ,foldopen:┬,foldclose:─,foldsep:┆]]

-- Execute .nvim.lua/.nvimrc/.exrc file in project directory
-- Only works for trusted files
vim.opt.exrc = true
