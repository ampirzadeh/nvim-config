vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
--       vim.cmd("cd %")
--       vim.cmd("Ex")
--     end
--   end
-- })

require("amp.settings")
require("amp.lazy")
require("amp.remaps")

vim.cmd.colorscheme("tokyodark")
require("nvim-tree").setup()
