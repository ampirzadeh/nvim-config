local global = vim.g
local o = vim.opt

-- Global options

global.mapleader = ","
global.maplocalleader = "\\"

-- Editor options

o.nu = true
o.relativenumber = true

o.autoindent = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.wrap = false

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.scrolloff = 10

o.cursorline = true
o.clipboard = "unnamedplus"
o.ruler = true
o.title = true
o.termguicolors = true
