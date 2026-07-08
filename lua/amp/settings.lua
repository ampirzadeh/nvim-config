local g = vim.g
local o = vim.opt

-- Global options
g.mapleader = " "
g.maplocalleader = ","

-- UI options
o.showmode = false               -- hides the --INSERT-- --NORMAL-- text under the statusline
o.number = true                  -- show line numbers
o.relativenumber = true          -- show line numbers relative to the cursor line
o.wrap = false                   -- don't wrap lines
o.whichwrap = o.whichwrap + "hl" -- move to the next line when the cursor reaches the end
o.cursorline = true              -- highlight the current line
o.ruler = true                   -- show the cursor position in the status line (it is currently redundant because of the lualine plugin)
o.title = true                   -- set the title of the terminal window to the name of the file
o.hlsearch = false               -- disable persistent search highlights
o.incsearch = true               -- highlights matches incrementally as they're being typed
o.scrolloff = 4                  -- keeps at least 4 lines visible above and below the cursor
o.termguicolors = true           -- enable 24-bit RGB colours

-- Indentation
o.autoindent = true  -- copy indentation from current line when starting a new line
o.expandtab = true   -- use spaces instead of tabs
o.shiftwidth = 2     -- number of spaces to use for each step of (auto)indent
o.tabstop = 2        -- number of spaces a tab character visually occupies
o.smartindent = true -- add extra indentation after {

-- File options
o.swapfile = false                               -- disable swap files
o.backup = false                                 -- disable backup files
o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- save undo history
o.undofile = true                                -- enable persistent undo to allow undoing after closing a file

-- Clipboard
o.clipboard = "unnamedplus" -- use the system clipboard

-- Diagnostics UI
vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true, -- always show source
    header = "",
    prefix = "",
  },
  virtual_text = true, -- Show diagnostics inline with the code
  signs = true,        -- Show signs in the gutter
  underline = true,    -- Underline problematic code
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
