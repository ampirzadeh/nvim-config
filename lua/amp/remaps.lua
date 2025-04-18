function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

Map("n", ";", ":")
Map("n", "<C-s>", ":w<CR>")

Map('i', '<C-v>', '<C-r>+')

-- Buffer management
Map('n', '<leader>x', ':bd<CR>')
Map('n', '<Tab>', ':bnext<CR>')
Map('n', '<S-Tab>', ':bprevious<CR>')

-- Move codeblocks around wtih Alt + hjkl
Map('n', "<A-j>", ":m .+1<CR>==")
Map('n', "<A-k>", ":m .-2<CR>==")
Map('n', "<A-Up>", ":m .-2<CR>==")
Map('n', "<A-Down>", ":m .+1<CR>==")

Map('i', "<A-j>", "<Esc>:m .+1<CR>==gi")
Map('i', "<A-k>", "<Esc>:m .-2<CR>==gi")
Map('i', "<A-Up>", "<Esc>:m .-2<CR>==gi")
Map('i', "<A-Down>", "<Esc>:m .+1<CR>==gi")

Map('v', "<A-k>", ":m '<-2<CR>gv=gv")
Map('v', "<A-j>", ":m '>+1<CR>gv=gv")
Map('v', "<A-Up>", ":m '<-2<CR>gv=gv")
Map('v', "<A-Down>", ":m '>+1<CR>gv=gv")

-- Move around with Ctrl + hjkl
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

-- terminal
Map("t", "<C-h>", ":wincmd h<CR>")
Map("t", "<C-j>", ":wincmd j<CR>")
Map("t", "<C-k>", ":wincmd k<CR>")
Map("t", "<C-l>", ":wincmd l<CR>")

-- Resize with Ctrl + direction keys
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- terminal
Map("t", "<C-Up>", ":resize -2<CR>")
Map("t", "<C-Down>", ":resize +2<CR>")
Map("t", "<C-Left>", ":vertical resize -2<CR>")
Map("t", "<C-Right>", ":vertical resize +2<CR>")

return Map;
