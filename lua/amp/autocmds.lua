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

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- Thanks to https://github.com/MeanderingProgrammer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('treesitter.setup', {}),
  callback = function(ev)
    local buf = ev.buf

    -- disable treesitter for files larger than:
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end

    -- avoid running on buffers that do not correspond to a language (like oil.nvim buffers)
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    if not vim.treesitter.language.add(lang) then
      return
    end

    -- enable treesitter
    if not vim.treesitter.start(buf, lang) then
      return
    end

    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
