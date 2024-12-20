return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" },
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
          "vue",
          "svelte",
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "c",
          "rust",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        -- rainbow = {
        --     enable = true,
        --     disable = { "html" },
        --     extended_mode = false,
        --     max_file_lines = nil,
        -- },
        -- context_commentstring = {
        --     enable = true,
        --     enable_autocmd = false,
        -- },
      })

      vim.diagnostic.config({
        virtual_text = true, -- Show diagnostics inline with the code
        signs = true,        -- Show signs in the gutter
        underline = true,    -- Underline problematic code
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  {
    "folke/ts-comments.nvim",
    event = { "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" },
    opts = {},
  }
}
