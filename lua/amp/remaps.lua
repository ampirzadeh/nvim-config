function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

Map("n", ";", ":")
Map({ "i", "n" }, "<C-s>", "<Esc>:w<CR>")

Map('i', '<C-v>', '<C-r>+')

-- Buffer management
Map('n', '<leader>x', ':bd<CR>') -- Close current buffer
Map("n", "<leader><leader>", "<C-^>") -- Toggle between most recently used buffer
Map('n', '<Tab>', ':bnext<CR>') -- Next buffer
Map('n', '<S-Tab>', ':bprevious<CR>') -- Previous Buffer

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

-- Terminal
Map("t", "<C-h>", ":wincmd h<CR>")
Map("t", "<C-j>", ":wincmd j<CR>")
Map("t", "<C-k>", ":wincmd k<CR>")
Map("t", "<C-l>", ":wincmd l<CR>")

-- Resize with Ctrl + direction keys
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Terminal
Map("t", "<C-Up>", ":resize -2<CR>")
Map("t", "<C-Down>", ":resize +2<CR>")
Map("t", "<C-Left>", ":vertical resize -2<CR>")
Map("t", "<C-Right>", ":vertical resize +2<CR>")

-- Join line, keeping the cursor position
Map("n", "J", "mzJ`z")

-- Search and replace entire word in normal mode
Map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]])
-- Search and replace entire selection in visual mode
Map("v", "<leader>r", [["hy:%s/<C-r>h//g<Left><Left><Left>]])

return Map;
