local languages = {
  "c",
  "cpp",
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
  "rust",
  "zig"
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    -- treesitter-modules takes care of this
    -- config = function()
    --   local treesitter = require("nvim-treesitter")
    --   treesitter.install(languages)
    -- end,
  },
  {
    -- MeanderingProgrammer himself suggests against using his plugin as it is very easy
    -- to implement everything he has done EXCEPT incremental selection which I cannot live without.
    --
    -- Hopefully there will come a day that nvim-treesitter come to their senses
    -- and support incremental selection out of the box LIKE HOW THEY USED TO.
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      ensure_installed = languages,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  }
}
