-- vim.keymap.set('n', '<C-b>', vim.cmd("Ex"), { noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<C-r>+')

vim.keymap.set('n', "<A-Up>", ":m .-2<CR>==")
vim.keymap.set('n', "<A-Down>", ":m .+1<CR>==")

vim.keymap.set('i', "<A-Up>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set('i', "<A-Down>", "<Esc>:m .+1<CR>==gi")

vim.keymap.set('v', "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set('v', "<A-Down>", ":m '>+1<CR>gv=gv")
