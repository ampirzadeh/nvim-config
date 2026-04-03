-- Big thanks to Sam Natale (https://github.com/smnatale) for some of these!

local Map = require("amp.remaps")

-- If there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    Map("n", "<leader>d", vim.diagnostic.open_float, opts)
    Map("n", "K", vim.lsp.buf.hover, opts)
    Map("n", "gd", vim.lsp.buf.definition, opts)
    Map("n", "gD", vim.lsp.buf.declaration, opts)
    Map("n", "gi", vim.lsp.buf.implementation, opts)
    Map("n", "go", vim.lsp.buf.type_definition, opts)
    Map("n", "gr", vim.lsp.buf.references, opts)
    Map("n", "gs", vim.lsp.buf.signature_help, opts)
    Map("n", '<F2>', vim.lsp.buf.rename, opts)
    Map("n", '<A-x>', function() vim.lsp.buf.format { async = true } end, opts)
    Map("n", '<F4>', vim.lsp.buf.code_action, opts)
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.hl.on_yank({ timeout = 200, visual = true })
  end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

-- show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
