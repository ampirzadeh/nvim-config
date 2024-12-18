require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
map("i", "<C-v>", "<C-r>+")

map("n", "<A-Up>", ":m .-2<CR>==")
map("n", "<A-Down>", ":m .+1<CR>==")

map("i", "<A-Up>", "<ESC>:m .-3<CR>==gi")
map("i", "<A-Down>", "<ESC>:m .+1<CR>==gi")

map("v", "<A-Up>", ":m '<-2<CR>gv=gv")
map("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- map({ "n", "x" }, "<A-x>", function()
--   vim.lsp.buf.format { async = true }
-- end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
