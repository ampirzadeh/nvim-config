return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" },
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      ---@diagnostic disable-next-line: missing-fields
      treesitter.setup({
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
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
      })

      vim.diagnostic.config({
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
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
}
