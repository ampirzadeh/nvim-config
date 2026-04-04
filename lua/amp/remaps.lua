function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

Map("n", ";", ":", { desc = "Enter command mode" })
Map({ "i", "n" }, "<C-s>", "<Esc>:w<CR>", { desc = "Write buffer" })

Map('i', '<C-v>', '<C-r>+', { desc = "Paste from clipboard" })

-- Buffer management
Map('n', '<leader>x', ':bd<CR>', { desc = "Close current buffer" })
Map("n", "<leader><leader>", "<C-^>", { desc = "Go to most recent buffer" })
Map('n', '<Tab>', ':bnext<CR>', { desc = "Go to next buffer" })
Map('n', '<S-Tab>', ':bprevious<CR>', { desc = "Go to previous buffer" })

for i = 1, 9 do
  Map("n", "<C-" .. i .. ">", function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if bufs[i] then
      vim.api.nvim_set_current_buf(bufs[i].bufnr)
    end
  end, { desc = "Go to buffer " .. i })
end

local global_marks = { "q", "w", "e", "r", "t", "y" }
for _, mark in ipairs(global_marks) do
  Map("n", "m" .. mark, "<cmd>mark " .. mark:upper() .. "<CR>", { desc = "Set mark (QWERTY are always global)" })
  Map("n", "'" .. mark, "<cmd>normal! '" .. mark:upper() .. "<CR>", { desc = "Jump to mark (QWERTY are always global)" })
end

-- Move codeblocks around wtih Alt + hjkl
Map('n', "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
Map('n', "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
Map('n', "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
Map('n', "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })

Map('i', "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map('i', "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
Map('i', "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map('i', "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

Map('v', "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
Map('v', "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
Map('v', "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
Map('v', "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- Move around split buffers with Ctrl + hjkl
Map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
Map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
Map("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
Map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Terminal
Map("t", "<C-h>", ":wincmd h<CR>", { desc = "Move to left split" })
Map("t", "<C-j>", ":wincmd j<CR>", { desc = "Move to bottom split" })
Map("t", "<C-k>", ":wincmd k<CR>", { desc = "Move to top split" })
Map("t", "<C-l>", ":wincmd l<CR>", { desc = "Move to right split" })

-- Resize split buffers with Ctrl + direction keys
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Terminal
Map("t", "<C-Up>", ":resize -2<CR>")
Map("t", "<C-Down>", ":resize +2<CR>")
Map("t", "<C-Left>", ":vertical resize -2<CR>")
Map("t", "<C-Right>", ":vertical resize +2<CR>")

Map("n", "J", "mzJ`z", { desc = "Join line, keeping the cursor position" })

Map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]],
  { silent = false, desc = "Search and replace entire word in normal mode" })
Map("v", "<leader>r", [["hy:%s/<C-r>h//g<Left><Left>]],
  { silent = false, desc = "Search and replace entire selection in visual mode" })

Map("n", "<leader>v", ":split<CR>", { desc = "Open split buffer horizontally" })
Map("n", "<leader>h", ":vsplit<CR>", { desc = "Open split buffer vertically" })

Map("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  { desc = "Toggle inlay hints" })


local function shrink_node()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end

local function expand_node()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end

-- goto next/previous treesitter node
-- useful for function parameters/arguments, if/then/else blocks, etc
Map({ 'x' }, '[[', function()
  require 'vim.treesitter._select'.select_prev(vim.v.count1)
end, { desc = 'Select previous treesitter node' })

Map({ 'x' }, ']]', function()
  require 'vim.treesitter._select'.select_next(vim.v.count1)
end, { desc = 'Select next treesitter node' })

-- Incremental selection
-- Thanks to https://pawelgrzybek.com/nvim-incremental-selection/
-- Normal mode:
-- <CR> to select parent node
-- <S-CR> to select child node
--
-- Visual mode:
-- <CR> or <Tab> to expand to parent node
-- <S-CR> or <S-Tab> to shrink tochild node
Map({ 'x', 'o' }, '<Tab>', expand_node,
  { desc = 'Select parent treesitter node or outer incremental lsp selections' })
Map({ 'x', 'o', 'n' }, '<CR>', expand_node,
  { desc = 'Select parent treesitter node or outer incremental lsp selections' })

Map({ 'x', 'o' }, '<S-Tab>', shrink_node,
  { desc = 'Select child treesitter node or inner incremental lsp selections' })
Map({ 'x', 'o', 'n' }, '<S-CR>', shrink_node,
  { desc = 'Select child treesitter node or inner incremental lsp selections' })

return Map;
